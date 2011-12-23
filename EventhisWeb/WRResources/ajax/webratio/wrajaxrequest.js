WRAjaxRequest = Class.create({  
	url: null,
	requestUrl: null,
	requestParams: null,
	isForm: null,
	pressedLink: null,
	onFailureCallBack: null,
	openWindow: null,
	closeWindow: null,
	openWaitingWindow: null,
	sourcePage: null,
	indicator: null,
	modal: false,
	autoResize: false,
	indicator: null,
	win: null,
	request: null,

	initialize: function(url, options) {
		this.url = url
		this.isForm = options.get("isForm")
		this.pressedLink =  options.get("pressedLink")
		this.onFailureCallBack = options.get("onFailureCallBack")
		this.openWindow = options.get("window")
		this.closeWindow = options.get("closeWindow")
		this.openWaitingWindow = options.get("waitingWindow")
		this.sourcePage = options.get("sourcePage")
		this.indicator =  options.get("indicator")

		if (this.openWindow && this.openWindow.get("modal")) {
			this.modal = this.openWindow.get("modal")
		}
		if (this.openWindow && this.openWindow.get("autoResizing")) {
			this.autoResize = this.openWindow.get("autoResizing")
		}
		
		Window.keepMultiModalWindow=true
	},

	sendRequest : function() {
		if (this.openWaitingWindow) {
			this.openInfoDialog();
		} else {
			this._request();
		}
	},
	
	openInfoDialog : function() { 
		Dialog.info(this.openWaitingWindow.get("message"), {className: this.openWaitingWindow.get("className"), width: this.openWaitingWindow.get("width"), height: this.openWaitingWindow.get("height"), showProgress: true}); 
		setTimeout(this._request.bind(this), this.openWaitingWindow.get("duration")) 
	},

	_request : function() { 
		WRAjaxRequestUtils.changeCursor("wait")
		if (this.indicator) {
	  		Element.show(this.indicator)
	  	}
		WRAjaxRequestUtils.clearNotification();
		try {
			var calculatedUrl = this.getUrl()
			this.requestUrl = calculatedUrl.get("url")
			this.requestParams = calculatedUrl.get("params")
			this.requestFormName = calculatedUrl.get("formName")
			this.requestFormInputs = calculatedUrl.get("formInputs")
		} catch(e) {
			WRAjaxRequestUtils.showNotification(e.message, null, e);
		}
		
		if (this.openWindow) {
			var that = this;
			this.request = new WRAjaxRequestQueue.DTO(this.requestUrl, {
			 method: 'post', 'postBody': this.requestParams, formName: this.requestFormName, formInputs: this.requestFormInputs,
			 onCreate: function(request) {
				WRAjaxRequestUtils.clearNotification();
				if (that.openWindow.get("showBeforeRequest")) {	
					try {
					   var response = "<div style='height:100%;vertical-align: middle' id='modal_dialog_progress' class='" + that.openWindow.get("className") + "_progress'>  </div>"
					   that.createAndPrepareWindow(response)
					} catch(e) {
						 that._onFailureCallback(e.message, null, e)
					}
				}
			 },
			 onSuccess: function(request) {
			 	var response = request.responseXML
			 	var responsePage = WRAjaxRequestUtils.getResponsePage(response)
				if (!response || !responsePage) {
				   response = request.responseText
				   try {
					  that.createAndPrepareWindow(response)
				   } catch(e) {
					  that._onFailureCallback(e.message, request.responseText, e)
				   }
				} else {
					try {
					  var response = request.responseXML
					  that.computeResponse(response)
					} catch(e) {
					  that._onFailureCallback(e.message, request.responseText)
					}
				}
			  }, onFailure: that._onFailureCallback,
			  onException: function(request, e) {
				  that._onFailureCallback(e.message, request.responseText, e);
			  }
			});
		} else {
			var that = this;
			this.request = new WRAjaxRequestQueue.DTO(this.requestUrl, {
				 method: 'post', 'postBody': this.requestParams, formName: this.requestFormName, formInputs: this.requestFormInputs,
				 onCreate: function() {
					WRAjaxRequestUtils.clearNotification();
				 },
				 onSuccess: function(request) {
						 try {
						   var response = request.responseXML
						   that.computeResponse(response)
						 } catch(e) {
							 that._onFailureCallback(e.message, request.responseText, e)
						 }
						 try {
							 var focusedElement = $(WREventUtils.getFocusedElement());
							 if (focusedElement) {
								 Form.Element.focus(focusedElement)
							 }
						 } catch (e) {
						 }
				 }, 
				 onFailure: that._onFailureCallback,
				  onException: function(request, e) {
					  that._onFailureCallback(e.message, request.responseText, e);
				  }
			});
		}
		WRAjaxRequestUtils.addRequest(this.request)
		WRAjaxRequestUtils.startRequest()
		
		WRAjaxRequestUtils.changeCursor("default")
		if (this.indicator) {
	  		Element.show(this.indicator)
	  	}
	},

    createAndPrepareWindow : function(response) {
	    if (this.openWaitingWindow) {
	        if (this.modal) {
	            WindowUtilities.hideModal = false;
	        }
	        Dialog.closeInfo();
	    }

	    if (this.closeWindow) {
	        if (this.modal) {
	            WindowUtilities.hideModal = false;
	        }
	        if (this.openWindow.get("showBeforeRequest")) {
	            var window = Windows.windows[Windows.windows.length - 2];
	            if (window != null) { 
	                window.close();
	                Windows.focusedWindow = this.win;
	            } 
	        } else {
	            var window = Windows.getFocusedWindow();
	            if (window != null) { 
	                window.close();
	            } 
	        }
	    }

	    var newWindow = false;
	    if (this.win == null) {
	        this.win = Windows.getWindow(this.openWindow.get("windowId") + "_window")
			if (this.win == null) {
			    this.win = new Window(this.openWindow.get("windowId") + "_window", this.openWindow);
			    newWindow = true
			}
	    }
	    if (this.openWindow.get("closable")) {
	        $(this.openWindow.get("windowId") + "_window_close").show();
	    }
        this.win.setHTMLContent(response);
        this.win.setConstraint(true, { left: 10, right: 10, top: 10, bottom: 10 });
        this.win.setDestroyOnClose(true);
        this.win.getContent().innerHTML.evalScripts();
        this.win.show();

        if (this.autoResize) {
            this.updateWindowSize.bind(this, this.win, this.modal & newWindow).defer();
        } else {
            this.win.showCenter(this.modal & newWindow);
        }
	},

    updateWindowSize: function(win, modal) {
	    win = win || Windows.getFocusedWindow();
		if (win) {		
		    if (win.content.scrollWidth == 0 || win.content.scrollHeight == 0) {
		        this.updateWindowSize.bind(this, win, modal).defer();
		    } else {   
		        win.updateWidth();
		        win.updateHeight();
		        win.showCenter(this.modal && modal);
		    }
		}
	},
	
	computeResponse : function(response) {
		var responsePage = WRAjaxRequestUtils.getResponsePage(response)	  
		if (this.openWaitingWindow) {
			Dialog.closeInfo()
		}
		if ((this.closeWindow && responsePage != this.sourcePage) || (!this.closeWindow && responsePage != this.sourcePage) || ((this.openWindow && this.openWindow.get("showBeforeRequest")) && responsePage == this.sourcePage)) {
			WindowUtilities.hideModal = true
			var window = Windows.getFocusedWindow()
			if (window != null) {
				window.close();
			}
		}
		WRAjaxRequestUtils.computeRequest(response)
		
		if (this.autoResize) {
			this.updateWindowSize(undefined, false)
		}
		
		WRAjaxRequestUtils.changeCursor("default")
		if (this.indicator) {
			Element.hide(this.indicator)
		}
	},
	
	getUrl : function(ignoreFields) {
		var ignore = true
		var url = this.url
		if (ignoreFields != undefined) {
			ignore = ignoreFields
		}
		try {
			
			if (!this.isForm) {
				var params = url.substring(url.indexOf("?") + 1, url.length)
				if (params != "") {
					params += "&"
				}
				params += "ajax=true"
				if (this.openWindow) {
				    params += "&openAjaxPopup=true"
				}
				if(this.closeWindow){
				    params += "&closeAjaxPopup=true"
				}
				var conditionInput = document.getElementById("conditions")
				params += "&" + conditionInput.name + "=" + encodeURIComponent(conditionInput.value)
				url = url.substring(0,url.indexOf("?")) 
			} else {
				var formName = url
				var url = "form_" + formName.substring(0, formName.indexOf("FormBean")) + ".do"
				
				/* Analyze form elements and recognize special fields */
				var formElements = Form.getElements(formName);
				var getters = $H();
				formElements.each(function(element) {
				    var handler = WRAjaxRequestUtils.fieldHandlers.find(function(h) {
				        return !!h.accept(element);
				    });
					if (handler) {
						getters.set(element.id, handler.getter);
					}
				});
				
				/*
				 * Filter out elements not to be included in the request.
				 * The submit check is needed because the serialize method does not filter 
                 * correctly these buttons in certain situation. So the application send another 
                 * AJAX request in GET.
				 */
				formElements = formElements.findAll(function (element) {
					var elementIgnore = element.getAttribute("ignore")
					return element.type != "submit" && element.type != "file" && element.type != "image" && (!elementIgnore && elementIgnore != ignore) && !getters.get(element.id);
				});
				
				/* Serialize values */
				var params = Form.serializeElements(formElements);
				getters.each(function(e) {
				    var content = e[1]($(e[0]));
				    params += "&" + encodeURIComponent(e[0]) + "=" + encodeURIComponent(content) 
				});
 				params += "&ajax=true"
				params += "&" + encodeURIComponent(this.pressedLink) + "=link"
				if (this.openWindow) {
				    params += "&openAjaxPopup=true"
				}
				if(this.closeWindow){
				    params += "&closeAjaxPopup=true"
				}
				
				/* Store encoded input values for all fields */
		        var formInputs = $H();
		        $(formName).select("input", "textarea").each(function(el) {
		        	var name = encodeURIComponent(el.name);
		        	var info = formInputs.get(name) || formInputs.set(name, { element: el, values: [] });
		        	info.values.push(encodeURIComponent(el.value));
		        });
			}
		
		} catch(e) {
			WRAjaxRequestUtils.showNotification(e.message, null, e);
		}
		return $H({"url": url, "params" : params, "formName": formName, "formInputs": formInputs})
	},
	
	_onFailureCallback: function(message, responseText, exception) {
		WRAjaxRequestUtils.showNotification(message, responseText, exception);
		if (this.onFailureCallBack && this.onFailureCallBack != "") {
			eval(this.onFailureFunction + "()");
		}
		WRAjaxRequestUtils.changeCursor("default");
		if (this.indicator) {
			Element.hide(this.indicator);
		}
	}
	
});

var WRAjaxRequestUtils = {
	AJAX_SPLITTER: "###",
	requestsQueue: new WRAjaxRequestQueue(),
	fieldHandlers: [],
	
	addRequest : function(request) {
		this.requestsQueue.add(request)
	},
	
	removeRequest : function(request) {
        this.requestsQueue.remove(request)
    },
    
	startRequest : function() {
		this.requestsQueue.start()
	},
	
	changeCursor : function(cursor) {
		document.body.style.cursor= cursor;
	},
	
	getResponsePage : function(response) {
		if (response && response.getElementsByTagName('Page').length > 0) {
		    var pageId = response.getElementsByTagName('Page')[0].getAttribute("qualifiedId")
			if(pageId){
			   return pageId
			}
			return response.getElementsByTagName('Page')[0].getAttribute("id")
		}
		return null
	},
	
	computeRequest: function(response) {
	  var page = response.getElementsByTagName('Page')[0]
	  try {
		  var pageHiddenFields = page.getAttribute("id") + 'HiddenFields'
		  var hiddenFields = page.getElementsByTagName(pageHiddenFields)[0]
		  
		  if (hiddenFields) {
			  var hiddenFieldsContent = ""
			  var textNodes = $A(hiddenFields.childNodes)
			  textNodes.each(function (text) {
				  hiddenFieldsContent += text.nodeValue
			  });
			  Element.update($(pageHiddenFields),hiddenFieldsContent)
		  }
	  } catch (e) {
		  WRAjaxRequestUtils.showNotification(e.message, null, e);
	  }
	  
	  var customLocations = $A(page.getElementsByTagName('CustomLocation'))
	  customLocations.each(function (e) {
		  WRAjaxRequestUtils.processElement(e)
	  })
	  var mainGrid = $A(page.getElementsByTagName('Grid')).find(function (c) {return (c.parentNode == page || c.parentNode.parentNode == page)})
	  WRAjaxRequestUtils.processElement(mainGrid)
	
	},

	processElement : function(element) {
	  var content = $A(element.getElementsByTagName("Content")).find(function (c) {return c.parentNode== element})
	  var units = $A(element.getElementsByTagName("Units")).find(function (e) {return e.parentNode == element})
	  var cells = $A(element.getElementsByTagName("Cells")).find(function (e) {return e.parentNode == element}) 
	  var grids = $A(element.getElementsByTagName("Grids")).find	(function (e) {return e.parentNode == element})
	  var subPages = $A(element.getElementsByTagName("SubPages")).find	(function (e) {return e.parentNode == element})
	  
	  var htmlContent = ""
	  
	  var elements = $A()
	  if (units) {
		  elements = elements.concat($A(units.getElementsByTagName("Unit")).findAll(function (c) {return c.parentNode== units}))
	  }
	  if (cells) {
		  elements = elements.concat($A(cells.getElementsByTagName("Cell")).findAll(function (c) {return c.parentNode== cells}))
	  }
	  if (grids) {
		  elements = elements.concat($A(grids.getElementsByTagName("Grid")).findAll(function (c) {return c.parentNode== grids}))
	  }
	  if (subPages) {
		  elements = elements.concat($A(subPages.getElementsByTagName("SubPage")).findAll(function (c) {return c.parentNode== subPages}))  
	  }
	  if (content != null && ((element.getAttribute("changed") == "true") || (element.getAttribute("changedConditions") == "true"))) {
		  var textNodes = $A(content.childNodes)
		  textNodes.each(function (text) {
			  htmlContent += text.nodeValue
		  });
  
		  var splittedContent = $A(htmlContent.split(WRAjaxRequestUtils.AJAX_SPLITTER)).findAll(function(token) {return (token.startsWith("__") && token.endsWith("__"))})
  		
		  splittedContent.each(function (token) {
			  var id = token.substring(2, token.length - 2)
			  var elem = elements.find(function (e) {
				   return e.getAttribute("id") == id		
			  });
			  if (elem) {
					  try {
					  var t = WRAjaxRequestUtils.AJAX_SPLITTER + "__" + id  + "__" + WRAjaxRequestUtils.AJAX_SPLITTER
					  var subContent = WRAjaxRequestUtils.processElementContent(elem)
					  htmlContent = htmlContent.replace(t, subContent)	
				  } catch(e) {
					  htmlContent = htmlContent.replace(t, "")	
				  }
			  } else {
				  try {
					  var t = WRAjaxRequestUtils.AJAX_SPLITTER + "__" + id  + "__" + WRAjaxRequestUtils.AJAX_SPLITTER
					  var content = ""
					  var textNodes = $A(elem.childNodes)
					  textNodes.each(function (text) {
						  content += text.nodeValue
					  });
					  
					  htmlContent = htmlContent.replace(t, content)	
					  } catch(e) {
						  htmlContent = htmlContent.replace(t, "")
					  }
			  }
		  });
		  
		  if (element.nodeName == "CustomLocation") {
				  if (htmlContent) {
					          WRAjaxRequestUtils.updateElement(element.getAttribute("id"), htmlContent)
						  } else {
							  WRAjaxRequestUtils.updateElement(element.getAttribute("id"), "")
						  }
		  } else {
			  return htmlContent
		  }
		  
	  } else {
		  elements.each(function (e) {
				  var id = e.getAttribute("id")
				  var content = WRAjaxRequestUtils.processElement(e)
				  if (content == null && content != undefined) {
					  content = ""
					  var textNodes = $A(element.getElementsByTagName("Content")[0].childNodes)
					  textNodes.each(function (text) {
						  content += text.nodeValue
					  });
				  }
				  if(e.getAttribute("changed") == "true" || e.getAttribute("changedConditions") == "true" ) {
					  try {
						  if (content) {
							  WRAjaxRequestUtils.updateElement(id, content)
						  } else {
							  WRAjaxRequestUtils.updateElement(id, "")
						  }
					  } catch (e) {
						  WRAjaxRequestUtils.showNotification(id + " " + e.message, null, e);
					  }
				  }
		  });
		  if (element.nodeName == "Unit" || (element.nodeName == "CustomLocation" && element.getAttribute("computed") == "true") || (element.nodeName == "Cell" && element.getAttribute("computed") == "true")) {
			  var id = element.getAttribute("id")
				  content = ""
				  
				  var textNodes = $A(element.getElementsByTagName("Content")[0].childNodes)
				  textNodes.each(function (text) {
					  content += text.nodeValue
				  });
				  
				  try {
					  if (content) {
						  WRAjaxRequestUtils.updateElement(id, content)
					  } else {
						  WRAjaxRequestUtils.updateElement(id, "")
					  }
				  } catch (e) {
					  WRAjaxRequestUtils.showNotification(id + " " + e.message, null, e);
				  }
		  }	
	  }
	},

	processElementContent : function(element) {
	  var content = $A(element.getElementsByTagName("Content")).find(function (c) {return c.parentNode== element})
	  var units = $A(element.getElementsByTagName("Units")).find(function (e) {return e.parentNode == element})
	  var cells = $A(element.getElementsByTagName("Cells")).find(function (e) {return e.parentNode == element}) 
	  var grids = $A(element.getElementsByTagName("Grids")).find	(function (e) {return e.parentNode == element})
	  var subPages = $A(element.getElementsByTagName("SubPages")).find	(function (e) {return e.parentNode == element})
	  var htmlContent = ""
	  
	  var elements = $A()
	  if (units) {
		  elements = elements.concat($A(units.getElementsByTagName("Unit")).findAll(function (c) {return c.parentNode== units}))
	  }
	  if (cells) {
		  elements = elements.concat($A(cells.getElementsByTagName("Cell")).findAll(function (c) {return c.parentNode== cells}))
	  }
	  if (grids) {
		  elements = elements.concat($A(grids.getElementsByTagName("Grid")).findAll(function (c) {return c.parentNode== grids}))
	  }
	  if (subPages) {
		  elements = elements.concat($A(subPages.getElementsByTagName("SubPage")).findAll(function (c) {return c.parentNode== subPages}))  
	  }

	  if (content) {
		  var textNodes = $A(content.childNodes)
		  textNodes.each(function (text) {
			  htmlContent += text.nodeValue
		  });
		   
		  var splittedContent = $A(htmlContent.split(WRAjaxRequestUtils.AJAX_SPLITTER)).findAll(function(token) {return (token.startsWith("__") && token.endsWith("__"))})
		  
		  splittedContent.each(function (token) {
			  var id = token.substring(2, token.length - 2)
			  var elem = elements.find(function (e) {
				   return e.getAttribute("id") == id		
			  });
			  
			  
			  if (elem) {
				  try {
					  var t = WRAjaxRequestUtils.AJAX_SPLITTER + "__" + id  + "__" + WRAjaxRequestUtils.AJAX_SPLITTER
					  var subContent = WRAjaxRequestUtils.processElementContent(elem)
					  htmlContent = htmlContent.replace(t, subContent)	
				  } catch(e) {
					  htmlContent = htmlContent.replace(t, "")	
				  }
			  } else {
				  try {
					  var t = WRAjaxRequestUtils.AJAX_SPLITTER + "__" + id  + "__" + WRAjaxRequestUtils.AJAX_SPLITTER
					  var content = ""
					  var textNodes = $A(elem.childNodes)
					  textNodes.each(function (text) {
						  content += text.nodeValue
					  });
					  
					  htmlContent = htmlContent.replace(t, content)	
					  } catch(e) {
						  htmlContent = htmlContent.replace(t, "")
					  }
			  }
		  });

		  return htmlContent
	  } else {
		  elements.each(function (e) {
			  var content = WRAjaxRequestUtils.processElementContent(e)
			  var t = WRAjaxRequestUtils.AJAX_SPLITTER + "__" + e.getAttribute("id")  + "__" + WRAjaxRequestUtils.AJAX_SPLITTER
			  htmlContent = htmlContent.replace(t, content)	
			  htmlContent = htmlContent.replace(t, content)	
		  });

		  return htmlContent
	  }
		  
  },
	
	updateElement: function(element, contents) {
		element = $(element);
		if (contents.indexOf("ajaxPreservedMarkup") >= 0) {
			var tmpEl = new Element("div");
			tmpEl.innerHTML = contents;
			tmpEl.select(".ajaxPreservedMarkup script").each(function(script) {
				var block = script.firstChild;
				if (!block || block.nodeType != 8 || !block.data.startsWith("wr{")) {
					script.insert({top: "<!--wr{preserve}-->"});
				}
			});
			element.innerHTML = tmpEl.innerHTML.replace(/<script[^>]*>(?!<!--wr\{preserve}-->)([\S\s]*?)<\/script>/g, "");
			contents.evalScripts.bind(contents).defer();
		} else if (element) {
			Element.update(element, contents);
		}
	},
	
  addDroppable: function(id, link, hoverClass, options) {
	if($(id)!=null){
		Droppables.drops = Droppables.drops.reject(function(d) {return d.element.id ==id });  
    	Droppables.add(id, {hoverclass: hoverClass, onDrop: function(element, droppableElement) {
			  var droppableUrl = droppableElement.getAttribute("url")
			  var droppableParams = droppableElement.getAttribute("params")
			  var draggableUrl = element.getAttribute("url")
			  var draggableParams = element.getAttribute("params")
				 
			  if (droppableUrl == draggableUrl) {
			   var queryString = new Hash()
			   queryString = queryString.merge(droppableParams.replace(/\+/g, "%20").toQueryParams());
			   queryString = queryString.merge(draggableParams.replace(/\+/g, "%20").toQueryParams());
			   var dragNDropUrl = droppableUrl + "?" + queryString.toQueryString(false)
			   return ajaxRequest(dragNDropUrl, $H(options))
			  }
			}
  		});
  	}
  },
  
	addFieldHandler: function(handler) {
		if (handler) this.fieldHandlers.push(handler);
	},
	
	showNotification: function(message, text, exception) {
		var notifDiv = $("ajaxNotification") || null;
		if (!notifDiv) {
			notifDiv = new Element("div", { 
				id: "ajaxNotification",
				style: "display: none"
			}).addClassName("ajaxNotificationDiv").update(WRAjax.messages.error);
			$(document.body).insert({top: notifDiv});
		}
		if (message) {
			var notifText = message;
			if (exception && exception.stack) {
				notifText += '<div style="display: none" class="ajaxExceptionTrace">EXCEPTION TRACE<pre>';
				notifText += exception.stack.replace(/</g, "&lt;");
				notifText += '</pre></div>';
			}
			if (text) {
				notifText += '<div style="display: none" class="ajaxResponseText">SERVER RESPONSE<pre>';
				notifText += text.replace(/</g, "&lt;");
				notifText += '</pre></div>';
			}
			notifDiv.update(notifText);
			notifDiv.observe("dblclick", function(event) {
				if (event.element().tagName != "PRE") {
					this.childElements().each(Element.toggle);
				}
			});
		}
		if (typeof Effect != "undefined") {
			Effect.Appear(notifDiv, { duration: 0.25, queue: "end" });
		} else {
			Element.show(notifDiv);
		}
	},
	
	clearNotification: function() {
		var notifDiv = $("ajaxNotification");
		if (notifDiv) {
		if (typeof Effect != "undefined") {
				Effect.Fade(notifDiv, { duration: 0.25, queue: "end" });
		} else {
				Element.hide(notifDiv);
			}
		}
	}
	
};

/*
 * Add support for CKEditor fields
 * TODO: move this together with CKEditor init/inclusion
 */
WRAjaxRequestUtils.addFieldHandler({
    accept: function(element) {
        return window.CKEDITOR && !!CKEDITOR.instances[element.name];
    },
    getter: function(element) {
        return CKEDITOR.instances[element.name].getData();
    }
});


if (typeof WRAjax == "undefined") {
	var WRAjax = {}
}

/**
 * Ajax.Request implemented with an hidden frame.
 */
WRAjax.FrameRequest = Class.create(Ajax.Request, {

    initialize: function($super, url, options) {
        $super(url, options);
        this.transport = new WRAjax.XMLFrameTransport(options.formName, options.formInputs);
        this.request(url, true);
    },

    request: function($super, url, initialized) {
        if (initialized) {
            $super(url);
        }
    }

});

/**
 * XMLHttpRequest implementation based on hidden IFrames.
 */
WRAjax.XMLFrameTransport = Class.create( {
    readyState: 0,
    onreadystatechange: null,
    status: 0,
    statusText: "",
    responseText: "",
    responseXML: null,
    _responseHeaders: null,
    _form: null,
    _formInputs: null,
    _iframe: null,
    _sending: false,
    _complete: false,
    _error: false,

    initialize: function(form, formInputs) {
        this._form = $(form);
        this._formInputs = formInputs;
    },

    open: function() {
        this._iframe = this._initFrame();
        this._changeState(1, true);
    },

    _initFrame: function() {
        var div = $("ajaxFramesDiv");
        if (!div) {
            div = new Element("div", {
                id: "ajaxFramesDiv",
                style: "position: absolute; display: none; height: 0; width: 0"
            });
            Element.insert(document.body, div);
        }
        var name = "ajaxRequest" + Math.floor(Math.random() * 0x7FFFFFFF);
        var iframe = new Element("iframe", {
            name: name,
            id: name,
            style: "display: none; height: 0; width: 0"
        });
        div.insert( {
            bottom: iframe
        });
        return iframe;
    },

    setRequestHeader: Prototype.K,

    send: function(body) {
        if (this._sending) {
            return;
        }
        this._complete = false;
        this._sending = true;
        this._responseHeaders = null;

        var oldFormAttrs = {};

        /* Add parameters to the form action */
        var actionParams = [];
        var bodyParams = $H();
        var re = /([^=&]+)=([^&]*)/g, m;
        while (m = re.exec(body)) {
        	var name = m[1];
    		var arr = bodyParams.get(name) || bodyParams.set(name, []);
    		arr.push(m[2]);
        }
        var formInputs = this._formInputs;
        bodyParams.each(function(param) {
        	var info = formInputs.get(param.key) || { element: null, values: [] };
        	var formValues = $A(info.values).sort();
        	var inputEl = info.element;
        	var handler = !inputEl ? null : WRAjaxRequestUtils.fieldHandlers.find(function(h) { return !!h.accept(inputEl); });
        	if (!handler && formValues.join("&") != param.value.sort().join("&")) {
        		param.value.each(function(v) {
        			actionParams.push(param.key + "=" + v);
        		});
        	}
        });
        if (typeof DOMParser === "undefined") {
        	actionParams.push("pxml=true");
        }
        if (actionParams.length > 0) {
            oldFormAttrs.action = this._form.readAttribute("action");
            this._form.writeAttribute("action", oldFormAttrs.action + "?" + actionParams.join("&"));
        }

        /* Bind event handlers */
        var okHandler = this._onComplete.bind(this, false);
        var koHandler = this._onComplete.bind(this, true);
        this._iframe.observe("complete", okHandler);
        this._iframe.observe("load", okHandler);
        this._iframe.observe("abort", koHandler);
        this._iframe.observe("error", koHandler);
        this._iframe.observe("load", this._destroyFrame.bind(this));

        /* Hijack the form */
        oldFormAttrs.target = this._form.readAttribute("target");
        this._form.writeAttribute("target", this._iframe.name);

        /* Submit the request and restore the form */
        this._form.submit();
        this._form.writeAttribute(oldFormAttrs);
    },

    abort: function() {
        this._finish(true);
        this._changeState(4, true);
        this._changeState(0, false);
    },

    _onComplete: function(error) {
        if (this._complete) {
            return;
        }
        this._complete = true;
        this._error = error;
        this._finish(false);
        this._changeState(4, true);
    },

    _finish: function(aborting) {
        if (aborting) {
            this.status = 0;
            this.statusText = "";
            this.responseText = "";
            this.responseXML = null;
            this._responseHeaders = null;
        } else {
            var doc = this._getFrameDocument();
            var resText = null;
            var resXML = null;
            if (doc.contentType && doc.contentType == "text/xml" || doc.xmlVersion) {
                resXML = this._cloneDocument(doc);
            } else if (doc.XMLDocument) {
                resXML = this._cloneDocument(doc.XMLDocument);
            } else {
                var docEl = $(doc.documentElement), docText;
				if (docEl) {
					resText = Element.Methods.getOuterHTML(docEl);
				}
				if (resText && resText.indexOf("#?xml") >= 0 && (docText = docEl.innerText) && docText.indexOf("#?xml") === 0) {
					resText = "<" + docText.substr(1);
					if (window.DOMParser) {
						var parser = new DOMParser();
						resXML = parser.parseFromString(resText, "text/xml");
					} else {
						resXML = new ActiveXObject("Microsoft.XMLDOM");
						resXML.async = "false";
						resXML.loadXML(resText);
					}
				}
            }
            this.status = 200;
            this.statusText = "OK";
            this.responseText = resText;
            this.responseXML = resXML;
            this._responseHeaders = {
                "content-type": resXML ? "text/xml" : "text/html"
            };
        }
        this._sending = false;
    },

    _cloneDocument: function(doc) {
        var cloned = doc.cloneNode(true);
        if (!cloned) {
            cloned = document.implementation.createDocument();
            cloned.replaceChild(cloned.importNode(doc.documentElement, true), cloned.documentElement);
        }
        return cloned;
    },

    _destroyFrame: function() {
        if (this._sending) {
            this._destroyFrame.bind(this).defer();
        } else {
            ( function() {
                this._iframe.remove();
            }).bind(this).delay(5);
        }
    },

    _getFrameDocument: function() {
        var doc = (this._iframe.contentWindow || this._iframe.contentDocument);
        if (doc.document) {
            doc = doc.document;
        }
        return doc;
    },

    getResponseHeader: function(name) {
        return (this._responseHeaders ? this._responseHeaders[name.toLowerCase()] : "");
    },

    getAllResponseHeaders: function() {
        if (!this._responseHeaders) {
            return null;
        } else {
            var s = "";
            for ( var name in this._responseHeaders) {
                s += name + ": " + this._reponseHeaders[name] + "\x0D\x0A";
            }
            return s;
        }
    },

    _changeState: function(state, raiseEvent) {
        this.readyState = state;
        if (raiseEvent) {
            (this.onreadystatechange || Prototype.K)();
        }
    }

});
