var WREventUtils = {
    _fieldsValues: $H(),
    _focusedElement: null,
    _lastFocusedFields: {},

    saveFieldValue: function(field) {
    	if (WREventUtils.getActiveAutocompleter(field)) {
    		return;
    	}
        if ($(field).getAttribute("forcefocus") != "true") {
            this._fieldsValues.set(field, Form.Element.getValue(field));
        }
    },
    
    updateFocusedElement: function() {
        if (arguments[0]) {
            var field = Event.element(arguments[0]);
            this._focusedElement = field.id;
            if (field.form) {
                this._lastFocusedFields[field.form.id] = field.id;
            }
        } else {
            this._focusedElement = null;
        }
    },
    
    getFocusedElement: function() {
        return this._focusedElement;
    },
    
    getLastFocusedField: function(form) {
        form = $(form);
        return form ? $(this._lastFocusedFields[form.id]) : null;
    },
    
    forgetForm: function(form) {
        form = $(form);
        if (form) {
            delete(this._lastFocusedFields[form.id]);
        }
    },
    
    fieldValueChanged: function(field) {
        var storedValue = this._fieldsValues.get(field);
        var fieldValue = Form.Element.getValue(field);
        return storedValue != fieldValue;
    },
    
    getActiveAutocompleter: function(field) {
		if (typeof Autocompleter !== "undefined") {
			var ac = Autocompleter.getInstance(field);
			if (ac && ac.active) {
				return ac;
			}
		}
		return null;
    },
    
	observe: (function() {
		if (!WRAjax.scriptOptimizations) {
			return function(element, eventName, handler) {
				try { Event.observe($(element), eventName, handler) } catch (e) {}
			};
		}
		
		var _priv = Event._privileged;
		
		function createWrapper(element, eventName, handler) {
			var id = _priv.getEventID(element);
			var c = _priv.getWrappersForEventName(id, eventName);
			var i, len;
			for (i = 0, len = c.length; i < len; i++) {
				if (c[i].handler === handler) {
					return false;
				}
			}

			var wrapper = function(event) {
				if (!Event || !Event.extend ||
				  (event.eventName && event.eventName != eventName))
					return false;

				Event.extend(event);
				handler.call(element, event);
			};

			wrapper.handler = handler;
			c.push(wrapper);
			return wrapper;
		}
		
		return function(element, eventName, handler) {
			try {
				if (typeof element === "string") {
					element = document.getElementById(element);
				}
				var wrapper = createWrapper(element, eventName, handler);
				if (wrapper) {
					if (element.addEventListener) {
						element.addEventListener(eventName, wrapper, false);
					} else {
						element.attachEvent("on" + eventName, wrapper);
					}
				}
			} catch (e) {}
		};
	})()
};

/**
 * Helper class for handling events by invoking an AJAX Event Link.
 */
var WREvent = {
	e: null,
	page: null,
	link: null,
	otherOptions: null,

	observe: function(event) {
		var options = $A(arguments);
		this.e = options[0];
		this.page = options[1];
		this.link = options[2];
		this.otherOptions = options[3];
		
		/* Avoid handling events caused by DOM manipulation in Chrome */
		if (Element.updatingElementsCount > 0) {
			return;
		}
		
		var alwaysFire = this.otherOptions.get("alwaysFire") || false;

		var elem = $(Event.element(event)), ac;
		var isField = elem.tagName.toLowerCase() == "input" || elem.tagName.toLowerCase() == "select" || elem.tagName.toLowerCase() == "textarea";
		if (isField && (alwaysFire || WREventUtils.fieldValueChanged(elem.id))) {
			if (ac = WREventUtils.getActiveAutocompleter(elem)) {
	    		var myThis = this, myArgs = arguments;
	    		ac.options.afterUpdateElement = function() {
	    			delete ac.options.afterUpdateElement;
	    			myArgs[3].set("alwaysFire", true);
	    			myArgs.callee.apply(myThis, myArgs);
	    		};
	    		return;
	    	}
			if (event.type == "focus") {
				if (elem.id != fieldWithFocus) {
					WREvent.doEvent();
				}
				WREventUtils.updateFocusedElement(elem.id);
			} else if (event.type == "blur") {
				if (elem.id == WREventUtils.getFocusedElement()) {
					WREventUtils.updateFocusedElement(null);
				}
				WREvent.doEvent();
			} else {
				WREventUtils.saveFieldValue(elem.id);
				WREvent.doEvent();
			}
		}
		if (!isField) {
			WREvent.doEvent();
		}   
	},
         
	doEvent: function() {
		ajaxRequest(this.page + "FormBean", $H({sourcePage: this.page, isForm: true, pressedLink: "button:" + this.link}).merge(this.otherOptions))
	}
};

function RadioRequest(page,link,field,lastValue,otherOptions){
    ajaxRequest(page + 'FormBean', $H({'sourcePage': page, 'isForm': true, 'pressedLink' : 'button:' + link}).merge(otherOptions))
};

function CheckboxRequest(page,link,field,lastValue,otherOptions){
    ajaxRequest(page + 'FormBean', $H({'sourcePage': page, 'isForm': true, 'pressedLink' : 'button:' + link}).merge(otherOptions))
};

Form.Element.RadioEventObserver = Class.create(Abstract.EventObserver,{
   initialize: function(form, name, callback) {
    this.elements = Form.getInputs(form, 'radio', name);
    this.callback = callback;
    for (var i = 0; i < this.elements.length; i++) {
      this.registerCallback(this.elements[i]);
    }
  },
  
  onElementEvent: function(event) {
    var element = Event.element(event);

    this.callback(element, Form.Element.getValue(element)); 
  }
});


Form.Element.CheckboxEventObserver = Class.create(Abstract.EventObserver,{
  
  initialize: function(form, name, callback) {
    this.elements = Form.getInputs(form, 'checkbox', name);
    this.callback = callback;
    for (var i = 0; i < this.elements.length; i++) {
      this.registerCallback(this.elements[i]);
    }
  },
  
  onElementEvent: function(event) {
   var element = Event.element(event);

   this.callback(element, Form.Element.getValue(element)); 
  }
  
});