var multiEntryMap = $H();
var multiChoiceMap = $H();

function removeRow(unitID, rowID){
    var lastIndex = multiEntryMap.get(unitID + 'LastIndex');
      var lastID = unitID + '[' + lastIndex + ']'; 
      var row = document.getElementById(rowID);
      var ds = document.getElementById(unitID + 'DataSize');
      var size = parseInt(ds.getAttribute('value')); 
      if(size > 1){
         var pRow = row.previousSibling;
         while(pRow != null && pRow.id == null){
           pRow = pRow.previousSibling;
         } 
         if(pRow == null){
           var nextRow = row.nextSibling;
           
           while(nextRow != null && nextRow.id == null){
              nextRow = nextRow.nextSibling;
           } 
           var nextHeader = document.getElementById(nextRow.id + 'Header');
           if(navigator.product == "Gecko"){
              nextHeader.style.display='table-row';
           }else{
              nextHeader.style.display='inline';
           }
         }
         row.parentNode.removeChild(row);
         size--;
         ds.setAttribute('value', size); 

         if(lastID == rowID){
           lastIndex--;
           lastID = unitID + '[' + lastIndex + ']'; 
           while(document.getElementById(lastID) == null){
             lastIndex--;
             lastID = unitID + '[' + lastIndex + ']'; 
           }
         } 
       } 
       multiEntryMap.set(unitID + 'LastIndex', lastIndex);
}

function addRow(unitID){
    var lastIndex = multiEntryMap.get(unitID + 'LastIndex');
      var lastRowId =  unitID + '[' + lastIndex + ']';
      var lastRow = document.getElementById(lastRowId);
      if (!lastRow) {
        lastIndex = 0
        lastRowId =  unitID + '[0]';
        lastRow = document.getElementById(lastRowId);
      }
      var mainDiv = document.getElementById(unitID);
      var newRowId = unitID + '[' + ++lastIndex + ']';
      var temp = lastRow.innerHTML;
      while(temp.indexOf(lastRowId) > 0){
        temp = temp.replace(lastRowId, newRowId);
      }
      var newDiv = document.createElement('div');
      newDiv.setAttribute('id',newRowId);
      while(temp.indexOf("selected") > 0){
        temp = temp.replace("selected", "");
      }   
      mainDiv.appendChild(newDiv);
      newDiv.innerHTML = temp;
      temp.evalScripts.bind(temp).defer();
      var ds =  document.getElementById(unitID + 'DataSize');
      var size = parseInt(ds.getAttribute('value')) + 1;
      ds.setAttribute('value',size);
      if(size >= 2){
         var header = document.getElementById(newRowId + 'Header');
         if (header) {
            header.style.display='none';
         }
      }
      var inputs = document.getElementsByTagName('input'); 
      if(inputs != null){
          for(var i=0; i < inputs.length; i++){
             var input = inputs.item(i);
             var name = input.getAttribute('name');
             var type = input.getAttribute('type');
             if(name!= null && name.indexOf(newRowId) > -1 && type != "radio" && type != "checkbox"){
               input.setAttribute('value','');
             }
          }
      }
      multiEntryMap.set(unitID + 'LastIndex', lastIndex);
}

function checkall(unit, index, prefix, anchor, selectAll, unselectAll) {
    var key = multiChoiceMap.get(unit + "_" + index)
    var returnValue = false
    var fields = document.getElementsByName(unit + prefix);
    for(var i=0; i < fields.length; i++){
        if ((!key || key == "all") && fields[i].id.substring(fields[i].id.indexOf('_') + 1,fields[i].id.lastIndexOf('_')) == index ) {
            fields[i].checked = true;
        } else if (key == "none" && fields[i].id.substring(fields[i].id.indexOf('_') + 1,fields[i].id.lastIndexOf('_')) == index ) {
            fields[i].checked = false;
        }
    }
    if((!key || key == "all")){
        key = "none";
        if ($(unit + index + "image")) {
            $(unit + index + "image").className='unSelectAll'
        }
        if (anchor) {
            if (anchor.tagName.toLowerCase() == "a") {
                anchor.innerHTML = unselectAll
            } else if (anchor.tagName.toLowerCase() == "input") {
                returnValue = true
            }
        }
    } else {
        key = "all";
        if ($(unit + index + "image")) {
            $(unit + index + "image").className='selectAll'
        }
        if (anchor) {
            if (anchor.tagName.toLowerCase() == "a") {
                anchor.innerHTML = selectAll
            } else if (anchor.tagName.toLowerCase() == "input") {
                returnValue = true
            }
        }
    }       
    multiChoiceMap.set(unit + "_" + index, key)                 

    return returnValue
}

function selectAll(fieldId, status) {
    var elements = document.getElementsByName(fieldId);
    for (var i = 0; i < elements.length; i++) {
        var el = elements[i];
        if (el.tagName.toLowerCase() == "select") {
            for (var j = 0; j < el.options.length; j++) {
                el.options[j].selected = status;
            }
        } else if (el.tagName.toLowerCase() == "input") {
            el.checked = status;
        }
    }
}

function clickButton(id) {
   var ids = id.split("|");
   for(var i=0; i < ids.length; i++){
     var button = $('button#' + ids[i]);
     if(button == null){
        button = $('button:' + ids[i]);
     }
     if(button != null && !button.disabled){
       button.click();
       break;
     }
   }
}

function forceFieldBlur(cal){
  cal.params.inputField.setAttribute("forcefocus", "true")
  cal.params.inputField.focus();
  cal.params.inputField.blur();
  cal.hide();
  setTimeout(function() {cal.params.inputField.setAttribute("forcefocus", "false")}, 100)
}

/*
 * Basic extensions
 */

Array.prototype.remove = function(o) {
	var i = this.indexOf(o);
	return i < 0 ? null : this.splice(i, 1)[0];
};

/*
 * Event extensions
 */
Event.observe = Event.observe.wrap(
    function($super, element, eventName, handler) {
        if (eventName == "dom:loaded" && element.tagName != "iframe") {
            var doc = element.ownerDocument || element;
            if (doc && doc.loaded) {
                if (handler) handler.defer();
                return element;
            }
        }
        return $super(element, eventName, handler);
    }
);

/*
 * Form extensions
 */
Object.extend(Form.Methods, {
	
	findFirstModifiableElement: function(form) {
		// Copied from prototype.js findFirstElement
		var elements = $(form).getElements().findAll(function(element) {
		  if(element.hasAttribute('tabIndex') && (element.tabIndex == -1)){
            return false;
          }
		  return 'hidden' != element.type && !element.disabled && !element.readOnly; 
		});
		var firstByIndex = elements.findAll(function(element) {
			return element.hasAttribute('tabIndex') && element.tabIndex >= 0;
		}).sortBy(function(element) { return element.tabIndex }).first();
		
		return firstByIndex ? firstByIndex : elements.find(function(element) {
			return ['input', 'select', 'textarea'].include(element.tagName.toLowerCase())
			       && !['button', 'submit'].include((element.type || '').toLowerCase());
		});
	},
	
	submitWithButton: function(form, buttonName) {
		var buttons = $(form).getInputs("submit", buttonName);
		if (!buttons[0]) throw { message: "Invalid button '" + buttonName + "'" };
		var oldAction = form.action;
		form.action += (form.action.indexOf("?") < 0 ? "?" : "&") + encodeURIComponent(buttons[0].name) + "=" + encodeURIComponent(buttons[0].value);
		form.submit();
		form.action = oldAction;
	}

});
Element.addMethods();

/*
 * Additional methods for all elements.
 * (do not move up: it needs method definitions from above)
 */
Element.updatingElementsCount = 0;
Element.addMethods({

    getOuterHTML: function(el) {
        if (el.outerHTML) {
            return el.outerHTML;
        } else {
            return "<" + el.tagName + ">" + el.innerHTML + "</" + el.tagName + ">";
        }
    },
    
    observe: Event.observe,
	
	update: Element.update.wrap(function($super, element, content) {
		try {
			Element.updatingElementsCount++;
			return $super(element, content);
		} finally {
			Element.updatingElementsCount--;
		}
	}),
	
	isUpdating: function(element) {
		return !!element._wr_updating;
	}
    
});
Object.extend(document, {

    observe: Element.Methods.observe.methodize(),
    
    getTopPageForm: function() {
        if (document.forms.length > 0) {
            return document.forms[document.forms.length - 1];
        } else {
            return undefined;
        }
    }
    
});

/*
 * Page focus management
 */
document.observe("dom:loaded", function() {
    var popups = $A();
    
    if (window.Windows) {
        Windows.addObserver({
        
            onShow: function(eventName, win) {
                var i = popups.indexOf(win.getId());
                if (i < 0) {
                    popups.push(win.getId());
                    var form = this._getWindowForm(win);
                    if (form) {
                        Event.fire(form, "wr:pageFocus");
                    }
                }
            },
            
            onDestroy: function(eventName, win) {
                var i = popups.indexOf(win.getId());
                if (i >= 0) {
                    WREventUtils.forgetForm(this._getWindowForm(win));
                    popups.splice(i, 1);
                    var form;
                    if (popups.length > 0) {
                        var win = Windows.getWindow(popups[popups.length - 1]);
                        form = this._getWindowForm(win);
                    } else {
                        form = document.getTopPageForm();
                    }
                    if (form) {
                        Event.fire(form, "wr:pageFocus");
                    }
                }
            },
            
            _getWindowForm: function(win) {
                return win.element.down("form");
            }
            
        });
    }

    var form = document.getTopPageForm();
    if (form) {
        Event.fire(form, "wr:pageFocus");
    }
});

/*
 * Form submission management
 */
document.observe("click", function(e) {
	var target = e.findElement();
	if (target.tagName == "INPUT" && target.type == "submit") {
		var form = target.up("form");
		form._wrSubmitButton = target.name;
	}
});

/*
 * Browser Integration
 */
document.observe("dom:loaded", function(e) {
	var div = $("_wr_page");
	if (div && typeof WebRatio == "undefined" && Prototype.Browser.Gecko) {
		div.update("WebRatio Browser Integration is enabled, but your browser is missing the required plugin: click here to install it.");
		div.addClassName("_wr_banner");
		div.writeAttribute("title");
		div.observe("click", function() {
			window.open("http://downloads.webratio.com/browsercontrol")
		});
	}
});
