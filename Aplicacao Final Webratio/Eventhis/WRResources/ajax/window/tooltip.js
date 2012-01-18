// Singleton class TooltipWindow
// This class works with special className. The tooltip content could be in your HTML page as an hidden element or
// can be retreive by an AJAX call.
//
// To work, You just need to set two class name on elements that should show tooltips
// - One to say to TooltipManager that this element must have a tooltip ('tooltip' by default)
// - Another to indicate how to find the tooltip content
//   It could be html_XXXX if tootltip content is somewhere hidden in your page, XXX must be DOM ID of this hidden element
//   It could be ajax_XXXX if tootltip content must be find by an ajax request, XXX will be the string send as id parameter to your server. 
// Check samples/tooltips/tooltip.html to see how it works
//
TooltipManager = {
  options: {cssClassName: 'tooltip', delayOver: 200, delayOut: 1000, shiftX: 10, shiftY: 10,
            className: 'alphacube', width: 200, height: null, event: 'mouseover',
            draggable: false, minimizable: false, maximizable: false, showEffect: Element.show, hideEffect: Element.hide, autoResizing: false},
  ajaxInfo: null,
  elements: null,
  showTimer: null,
  hideTimer: null,

  // Init tooltip manager
  // parameters:
  // - cssClassName (string) : CSS class name where tooltip should be shown. 
  // - ajaxOptions  (hash)   : Ajax options for ajax tooltip. 
  //                           For examples {url: "/tooltip/get.php", options: {method: 'get'}} 
  //                           see Ajax.Request documentation for details
  //- tooltipOptions (hash)  : available keys
  //                           - delayOver: int in ms (default 10) delay before showing tooltip
  //                           - delayOut:  int in ms (default 1000) delay before hidding tooltip
  //                           - shiftX:    int in pixels (default 10) left shift of the tooltip window 
  //                           - shiftY:    int in pixels (default 10) top shift of the tooltip window 
  //                           and All window options like showEffect: Element.show, hideEffect: Element.hide to remove animation
  //                           default: {className: 'alphacube', width: 200, height: null, draggable: false, minimizable: false, maximizable: false}
  
  init: function(cssClassName, ajaxInfo, tooltipOptions) {
    TooltipManager.options = Object.extend(TooltipManager.options, tooltipOptions || {});
    
    cssClassName = $H(TooltipManager.options).get("cssClassName") || "tooltip";
    TooltipManager.ajaxInfo = ajaxInfo;
    TooltipManager.elements = $$("." + cssClassName);
    TooltipManager.elements.each(function(element) {
      element = $(element)
      var info = TooltipManager._getInfo(element);
      if (info.ajax) {
        element.ajaxId = info.id;
        element.ajaxInfo = ajaxInfo;
      }
      else {
        element.tooltipElement = $(info.id);
      }
      /* WEBRATIO
         Aggiunta l'istruzione che permette di associare l'evento all'elemento
         che deve mostrare il tooltip.
      */
      this.addEvent(element, $H(TooltipManager.options).get("event"));
      /*element.observe("mouseover", TooltipManager._mouseOver);
      element.observe("mouseout", TooltipManager._mouseOut);*/
    });
    Windows.addObserver(this);
  },
  
  /* WEBRATIO
     Metodo che permette di associare un evento all'elemento a cui si vuole
     associare il tooltip. 
  */
  addEvent: function(element, eventName) {
    if (eventName == 'mouseover') {
      element.observe("mouseover", TooltipManager._mouseOver);
      element.observe("mouseout", TooltipManager._mouseOut);
    } else if (eventName == 'click') {
    	if (element.name != "input") {
			 element.onselectstart = function () { return false; } // ie
			 element.onmousedown = function () { return false; } // mozilla
			}
      element.observe("click", TooltipManager._click);
      //element.observe("mouseout", TooltipManager._mouseOut);
    } else if (eventName == 'doubleClick') {
    	if (element.name != "input") {
			 element.onselectstart = function () { return false; } // ie
			 element.onmousedown = function () { return false; } // mozilla
			}
      element.observe("dblclick", TooltipManager._dblClick);
      //element.observe("mouseout", TooltipManager._mouseOut);
    }
  },
  
  addHTML: function(element, tooltipElement) {
    element = $(element);
    tooltipElement = $(tooltipElement);
    element.tooltipElement = tooltipElement;
    /* WEBRATIO: Flag per marcare gli elementi root con tooltip */
	element.isTooltipRoot = true;
    
   /* WEBRATIO
         Aggiunta l'istruzione che permette di associare l'evento all'elemento
         che deve mostrare il tooltip.
      */
      this.addEvent(element, $H(TooltipManager.options).get("event"));
  },
  
  addAjax: function(element, ajaxInfo) {
    element = $(element);
    element.ajaxInfo = ajaxInfo;
    /* WEBRATIO: Flag per marcare gli elementi root con tooltip */
	element.isTooltipRoot = true;
   /* WEBRATIO
         Aggiunta l'istruzione che permette di associare l'evento all'elemento
         che deve mostrare il tooltip.
      */
      this.addEvent(element, $H(TooltipManager.options).get("event"));
  },
    
  addURL: function(element, url, width, height) {
    element = $(element);
    element.url = url;
    element.frameWidth = width;
    element.frameHeight = height;
    /* WEBRATIO: Flag per marcare gli elementi root con tooltip */
	element.isTooltipRoot = true;
    /* WEBRATIO
         Aggiunta l'istruzione che permette di associare l'evento all'elemento
         che deve mostrare il tooltip.
      */
      this.addEvent(element, $H(TooltipManager.options).get("event"));
  },
    
  close: function() {
    if (TooltipManager.tooltipWindow)
      TooltipManager.tooltipWindow.hide();
  },
  
  preloadImages: function(path, images, extension) {
    if (!extension)
      extension = ".gif";
      
    //preload images
    $A(images).each(function(i) {
      var image = new Image(); 
      image.src= path + "/" + i + extension; 
    });
  },

  _showTooltip: function(element) {
    /*  WEBRATIO  */
    if ($H(TooltipManager.options).get("event") == 'mouseover' && this.element == element)
      return;
    // Get original element
    while (element && (!element.tooltipElement && !element.ajaxInfo && !element.url)) 
      element = element.parentNode;
    this.element = element;
    
    TooltipManager.showTimer = null;
    if (TooltipManager.hideTimer)
      clearTimeout(TooltipManager.hideTimer);
    
    var position = Position.cumulativeOffset(element);
    var dimension = element.getDimensions();

    if (! this.tooltipWindow)
      this.tooltipWindow = new Window("__tooltip__", TooltipManager.options);
      
    this.tooltipWindow.hide();
    this.tooltipWindow.setLocation(position[1] + dimension.height + $H(TooltipManager.options).get("shiftY"), position[0] + $H(TooltipManager.options).get("shiftX"));
		
		/*  WEBRATIO
        Associa l'observer sull'evento desiderato 
    */
    this.addEvent(element, $H(TooltipManager.options).get("event"));
    /*if (TooltipManager.options.event=='mouseover') {
      Event.observe(this.tooltipWindow.element, "mouseover", function(event) {TooltipManager._tooltipOver(event, element)});
      Event.observe(this.tooltipWindow.element, "mouseout", function(event) {TooltipManager._tooltipOut(event, element)});
    } else if (TooltipManager.options.event=='click') {
      Event.observe(this.tooltipWindow.element, "click", function(event) {TooltipManager._tooltipClick(event, element)});
      Event.observe(this.tooltipWindow.element, "mouseout", function(event) {TooltipManager._tooltipOut(event, element)});
    } else if (TooltipManager.options.event=='dblclick') {
      Event.observe(this.tooltipWindow.element, "dblclick", function(event) {TooltipManager._tooltipClick(event, element)});
      Event.observe(this.tooltipWindow.element, "mouseout", function(event) {TooltipManager._tooltipOut(event, element)});
    }
    Event.observe(this.tooltipWindow.element, "mouseover", function(event) {TooltipManager._tooltipOver(event, element)});
    Event.observe(this.tooltipWindow.element, "mouseout", function(event) {TooltipManager._tooltipOut(event, element)});*/

    // Reset width/height for computation
    this.tooltipWindow.height = $H(TooltipManager.options).get("height");
    this.tooltipWindow.width = $H(TooltipManager.options).get("width");

    // Ajax content
    if (element.ajaxInfo) {
    
      var p = $H(element.ajaxInfo.options).get("parameters");
      var saveParam = p;
      
      // Set by CSS
      if (element.ajaxId) {
        if (p)
          p += "&id=" + element.ajaxId;
        else
          p = "id=" + element.ajaxId;
      }
      var map = $H(element.ajaxInfo.options)
      var x = p || ""
      map.set("parameters", x);
      element.ajaxInfo.options = map
      this.tooltipWindow.setHTMLContent("");
       /* 05-12-2008 ADDED SET Size WHEN fixed dimensions are used */
      if($H(element.ajaxInfo.options).get("width") != null && $H(element.ajaxInfo.options).get("width") != "" && $H(element.ajaxInfo.options).get("height") != null && $H(element.ajaxInfo.options).get("height") != ""){
 	      this.tooltipWindow.setSize($H(element.ajaxInfo.options).get("width"), $H(element.ajaxInfo.options).get("height"));
 	    }

		// WR bug 3516
		this.tooltipWindow.tooltipElement = element;
		// WR end
		
      this.tooltipWindow.setAjaxContent(element.ajaxInfo.url, element.ajaxInfo.options);
 	  
 	  
 	  /* WR */
      //setTimeout(function() {TooltipManager._updateTooltip()}, 200) 
      	var map = $H(element.ajaxInfo.options)
		    map.set("parameters", saveParam);
		    element.ajaxInfo.options = map   
    } 
    // URL content
    else if (element.url) {
      this.tooltipWindow.setURL(element.url);
      this.tooltipWindow.setSize(element.frameWidth, element.frameHeight);

      // Set tooltip size
      this.tooltipWindow.height = element.frameHeight;
      this.tooltipWindow.width = element.frameWidth;
    }
    // HTML content
    else
      this.tooltipWindow.setHTMLContent(element.tooltipElement.innerHTML);

    if (!element.ajaxInfo) {
      this.tooltipWindow.show();
      this.tooltipWindow.toFront();
    }
  },
  /* WR */
  _updateTooltip : function() {
	  this.tooltipWindow.getSize()
  	  this.tooltipWindow.updateWidth();
      this.tooltipWindow.updateHeight();
	},
	
  _hideTooltip: function(element) {
    if (this.tooltipWindow) {
      this.tooltipWindow.hide();
      this.element = null;
    }
  },
  /*  WEBRATIO
    Aggiunto evento click in modo che il tooltip si possa attivare anche al 
    click del mouse sull'elemento.
*/  
  _click: function (event) {
    var element = Event.element(event);
    if (event.pageY) {
			var top = event.pageY;
			var left = event.pageX;
		} else if (event.clientY) {
			// put an If here instead, ?: doesn't seem to work
			if (document.body.scrollTop > document.documentElement.scrollTop) {
				var top = event.clientY + document.body.scrollTop;
			} else {
				var top = event.clientY + document.documentElement.scrollTop;
			}

			if (document.body.scrollLeft > document.documentElement.scrollLeft) {
				var left = event.clientX + document.body.scrollLeft;
			} else {
				var left = event.clientX + document.documentElement.scrollLeft;
			}
		}
			var map = $H(TooltipManager.options)
		map.set("top",top);
		map.set("left",left);
		TooltipManager.options = map
		
    if (TooltipManager.showTimer) 
      clearTimeout(TooltipManager.showTimer);
    
    TooltipManager.showTimer = setTimeout(function() {TooltipManager._showTooltip(element)}, $H(TooltipManager.options).get("delayOver")) 
  },
  /*  WEBRATIO
    Aggiunto evento dblClick in modo che il tooltip si possa attivare anche al 
    click del mouse sull'elemento.
*/  
  _dblClick: function (event) {
    var element = Event.element(event);
    element.onselectstart = function () { return false; } // ie
  	element.onmousedown = function () { return false; } // mozilla
    if (event.pageY) {
			var top = event.pageY;
			var left = event.pageX;
		} else if (event.clientY) {
			// put an If here instead, ?: doesn't seem to work
			if (document.body.scrollTop > document.documentElement.scrollTop) {
				var top = event.clientY + document.body.scrollTop;
			} else {
				var top = event.clientY + document.documentElement.scrollTop;
			}

			if (document.body.scrollLeft > document.documentElement.scrollLeft) {
				var left = event.clientX + document.body.scrollLeft;
			} else {
				var left = event.clientX + document.documentElement.scrollLeft;
			}
		}
			var map = $H(TooltipManager.options)
		map.set("top",top);
		map.set("left",left);
		TooltipManager.options = map
    if (TooltipManager.showTimer) 
      clearTimeout(TooltipManager.showTimer);
    
    TooltipManager.showTimer = setTimeout(function() {TooltipManager._showTooltip(element)}, $H(TooltipManager.options).get("delayOver")) 
  },
  
  _mouseOver: function (event) {
    var element = Event.element(event);
    /* WEBRATIO: controllo che si tratti di un vero ingresso in un tooltip */
	var fromElement = event.relatedTarget || event.fromElement;
	if (TooltipManager._getTooltipRoot(element) == TooltipManager._getTooltipRoot(fromElement)) {
	  return;
	}
        if (event.pageY) {
			var top = event.pageY;
			var left = event.pageX;
		} else if (event.clientY) {
			// put an If here instead, ?: doesn't seem to work
			if (document.body.scrollTop > document.documentElement.scrollTop) {
				var top = event.clientY + document.body.scrollTop;
			} else {
				var top = event.clientY + document.documentElement.scrollTop;
			}

			if (document.body.scrollLeft > document.documentElement.scrollLeft) {
				var left = event.clientX + document.body.scrollLeft;
			} else {
				var left = event.clientX + document.documentElement.scrollLeft;
			}
		}
		var map = $H(TooltipManager.options)
		map.set("top",top);
		map.set("left",left);
		TooltipManager.options = map
    if (TooltipManager.showTimer) 
      clearTimeout(TooltipManager.showTimer);
    TooltipManager.showTimer = setTimeout(function() {TooltipManager._showTooltip(element)}, $H(TooltipManager.options).get("delayOver"))
  },
  
  _mouseOut: function(event) {
    var element = Event.element(event);
    /* WEBRATIO: controllo che si tratti di una vera uscita da un tooltip */
	var toElement = event.relatedTarget || event.toElement;
	if (TooltipManager._getTooltipRoot(element) == TooltipManager._getTooltipRoot(toElement)) {
	  return;
	}
    element.onselectstart = function () { return true; } // ie
  	element.onmousedown = function () { return true; } // mozilla
    if (TooltipManager.showTimer) {
      clearTimeout(TooltipManager.showTimer);
      TooltipManager.showTimer = null;
      return;
    }
    if (TooltipManager.tooltipWindow)
      TooltipManager.hideTimer = setTimeout(function() {TooltipManager._hideTooltip(element)}, $H(TooltipManager.options).get("delayOut"))
  },
  
  _tooltipOver: function(event, element) {
    if (TooltipManager.hideTimer) {
      clearTimeout(TooltipManager.hideTimer);
      TooltipManager.hideTimer = null;
    }
  },
  
  _tooltipOut: function(event, element) {
    if (TooltipManager.hideTimer == null)
      TooltipManager.hideTimer = setTimeout(function() {TooltipManager._hideTooltip(element)}, $H(TooltipManager.options).get("delayOut"))
  },
  
  /* WEBRATIO: funzione per ricavare l'eventuale elemento top-level cui è applicato un tooltip */
  _getTooltipRoot: function(element) {
    if (element) {
      do {
        if (element.isTooltipRoot) return element;
      } while (element = element.parentNode);
	}
	return null;
  },
  
  _getInfo: function(element) {
    // Find html_ for static content
    var id = element.className.split(' ').detect(function(name) {return name.indexOf("html_") == 0});
    var ajax = true;
    if (id)
      ajax = false;
    else 
      // Find ajax_ for ajax content
      id = element.className.split(' ').detect(function(name) {return name.indexOf("ajax_") == 0});
    
    id = id.substr(id.indexOf('_')+1, id.length)
    return id ? {ajax: ajax, id: id} : null;
  },
  
  onBeforeShow: function(eventName, win) {
	// WR bug 3516
	var ajaxInfo = win.tooltipElement ? win.tooltipElement.ajaxInfo : null;
	if (ajaxInfo && $H(ajaxInfo.options).get("autoResizing") == "true") {
		TooltipManager._updateTooltip.bind(TooltipManager).defer();
	}
  	//if ($H(TooltipManager.options).get("autoResizing") == "true") {
  	//	setTimeout(function() {TooltipManager._updateTooltip()}, 200) 
  	//}
	// WR end
  	 
     var top = parseFloat(win.getLocation().top);
     var dim = win.element.getDimensions();
          
      var winWidth = dim.width;
      var winHeight = dim.height;
      var documentWidth = window.innerWidth + window.pageXOffset || document.documentElement.clientWidth + document.documentElement.scrollLeft || 0;
      var documentHeight = window.innerHeight + window.pageYOffset || document.documentElement.clientHeight + document.documentElement.scrollTop|| 0;
      

/*  WEBRATIO
    Controllo che esista un elemento associato al tooltip. Necessario nel caso in
    cui si utilizzi in una stessa pagina sia il tooltip che le finestre. 
*/
       if(this.element){
              
         var position = Position.cumulativeOffset(this.element);
         var top = 0
         var left = 0
         if (($H(TooltipManager.options).get("top") + winHeight) < documentHeight || documentHeight == 0) {
           top = $H(TooltipManager.options).get("top") + $H(TooltipManager.options).get("shiftY");
         } else {
         top = 0
      
           top = $H(TooltipManager.options).get("top") - ($H(TooltipManager.options).get("top") + winHeight - documentHeight);
           if (document.documentElement.clientWidth) {
            top -= 50
           }
          
         }
         if (($H(TooltipManager.options).get("left") + winWidth) < documentWidth || documentWidth == 0) {
           left = $H(TooltipManager.options).get("left") + $H(TooltipManager.options).get("shiftX");
         } else {
           left = $H(TooltipManager.options).get("left") - ($H(TooltipManager.options).get("left") + winWidth - documentWidth);
         }

         win.setLocation(top, left)  	 
       
     }
     
   },

	_getPageWidth: function(){
		return window.innerWidth || document.documentElement.clientWidth || 0;
	},
	
	_getPageHeight: function(){
		return window.innerHeight || document.documentElement.clientHeight || 0;
	},

	_getScrollTop: function(){
		return document.documentElement.scrollTop || window.pageYOffset || 0;
	},

	_getScrollLeft: function(){
		return document.documentElement.scrollLeft || window.pageXOffset || 0;
	}	
};
