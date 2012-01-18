// Copyright (c) 2006 Sébastien Gruhier (http://xilinus.com, http://itseb.com)
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// VERSION 1.3

var Window = Class.create();

Window.keepMultiModalWindow = false;
Window.hasEffectLib = (typeof Effect != 'undefined');
Window.resizeEffectDuration = 0.4;

Window.prototype = {
  // Constructor
  // Available parameters : className, blurClassName, title, minWidth, minHeight, maxWidth, maxHeight, width, height, top, left, bottom, right, resizable, zIndex, opacity, recenterAuto, wiredDrag
  //                        hideEffect, showEffect, showEffectOptions, hideEffectOptions, effectOptions, url, draggable, closable, minimizable, maximizable, parent, onload
  //                        add all callbacks (if you do not use an observer)
  //                        onDestroy onStartResize onStartMove onResize onMove onEndResize onEndMove onFocus onBlur onBeforeShow onShow onHide onMinimize onMaximize onClose
  
  initialize: function() {
    var id;
    var optionIndex = 0;
    // For backward compatibility like win= new Window("id", {...}) instead of win = new Window({id: "id", ...})
    if (arguments.length > 0) {
      if (typeof arguments[0] == "string" ) {
        id = arguments[0];
        optionIndex = 1;
      }
      else
        id = arguments[0] ? arguments[0].id : null;
    }
    
    // Generate unique ID if not specified
    if (!id)
      id = "window_" + new Date().getTime();
      
    /*if ($(id))
      alert("Window " + id + " is already registered in the DOM! Make sure you use setDestroyOnClose() or destroyOnClose: true in the constructor");
*/
     this.options = {
      className:         "dialog",
      blurClassName:     null,
      minWidth:          100, 
      minHeight:         20,
      maxWidth:          (window.innerWidth || Element.getWidth(document.documentElement)) - 70, // WR
      maxHeight:         (window.innerHeight || Element.getHeight(document.documentElement)) - 70, // WR
      resizable:         true,
      closable:          true,
      minimizable:       true,
      maximizable:       true,
      draggable:         true,
      userData:          null,
      showEffect:        (Window.hasEffectLib ? Effect.Appear : Element.show),
      hideEffect:        (Window.hasEffectLib ? Effect.Fade : Element.hide),
      showEffectOptions: {},
      hideEffectOptions: {},
      effectOptions:     null,
      parent:            document.body,
      title:             "&nbsp;",
      url:               null,
      onload:            Prototype.emptyFunction,
      width:             200,
      height:            300,
      opacity:           1,
      recenterAuto:      true,
      wiredDrag:         false,
      closeCallback:     null,
      destroyOnClose:    false,
      showBeforeRequest: false,
      gridX:             1, 
      gridY:             1,
      zIndex: 10000
    };
    
    this.options = $H(this.options).update($H(arguments[optionIndex]))
     /* 23-01-2009 ADDED Map Managmenet for Prototype 6 */
    if ($H(this.options).get("blurClassName")){
      var map = $H(this.options)
      map.set("focusClassName", $H(this.options).get("className"));
      this.options = map
    }  

    if (typeof $H(this.options).get("top") == "undefined" &&  typeof $H(this.options).get("bottom") ==  "undefined") {
    /* 23-01-2009 ADDED Map Managmenet for Prototype 6 */
      var map = $H(this.options)
      map.set("top", this._round(Math.random()*500, $H(this.options).get("gridY")));
      this.options = map
    }  
    if (typeof $H(this.options).get("left") == "undefined" &&  typeof $H(this.options).get("right") ==  "undefined") {
      var map = $H(this.options)
      map.set("left", this._round(Math.random()*500, $H(this.options).get("gridX")));
      this.options = map    
    }  
    if ($H(this.options).get("effectOptions")) {
      Object.extend($H(this.options).get("hideEffectOptions"), $H(this.options).get("effectOptions"));
      Object.extend($H(this.options).get("showEffectOptions"), $H(this.options).get("effectOptions"));
      if ($H(this.options).get("showEffect") == Element.Appear){
        var map = $H(this.options)
        map.set("showEffectOptions").set("to") = $H(this.options).get("opacity");
        this.options = map 
      }
    }
    if (Window.hasEffectLib) {
      if ($H(this.options).get("showEffect") == Effect.Appear)
        $H($H(this.options).get("showEffectOptions")).set("to", $H(this.options).get("opacity"));
    
      if ($H(this.options).get("hideEffect") == Effect.Fade)
        $H($H(this.options).get("showEffectOptions")).set("from", $H(this.options).get("opacity"));
    }
    if ($H(this.options).get("hideEffect") == Element.hide)
      $H(this.options).set("hideEffect", function(){ Element.hide(this.element); if ($H(this.options).get("destroyOnClose")) this.destroy(); }.bind(this))
    
    if ($H(this.options).get("parent") != document.body)  
      $H(this.options).set("parent",  $($H(this.options).get("parent")));
        
    this.element = this._createWindow(id);       
    this.element.win = this;
    // Bind event listener
    this.eventMouseDown = this._initDrag.bindAsEventListener(this);
    this.eventMouseUp   = this._endDrag.bindAsEventListener(this);
    this.eventMouseMove = this._updateDrag.bindAsEventListener(this);
    this.eventOnLoad    = this._getWindowBorderSize.bindAsEventListener(this);
    this.eventMouseDownContent = this.toFront.bindAsEventListener(this);
    this.eventResize = this._recenter.bindAsEventListener(this);
 
    this.topbar = $(this.element.id + "_top");
    this.bottombar = $(this.element.id + "_bottom");
    this.content = $(this.element.id + "_content");
    
    Event.observe(this.topbar, "mousedown", this.eventMouseDown);
    Event.observe(this.bottombar, "mousedown", this.eventMouseDown);
    Event.observe(this.content, "mousedown", this.eventMouseDownContent);
    Event.observe(window, "load", this.eventOnLoad);
    Event.observe(window, "resize", this.eventResize);
    Event.observe(window, "scroll", this.eventResize);
    Event.observe($H(this.options).get("parent"), "scroll", this.eventResize);
    
    if ($H(this.options).get("draggable"))  {
      var that = this;
      [this.topbar, this.topbar.up().previous(), this.topbar.up().next()].each(function(element) {
        element.observe("mousedown", that.eventMouseDown);
        element.addClassName("top_draggable");
      });
      [this.bottombar.up(), this.bottombar.up().previous(), this.bottombar.up().next()].each(function(element) {
        element.observe("mousedown", that.eventMouseDown);
        element.addClassName("bottom_draggable");
      });
      
    }    
    
    if ($H(this.options).get("resizable")) {
      this.sizer = $(this.element.id + "_sizer");
      Event.observe(this.sizer, "mousedown", this.eventMouseDown);
    }  
    
    this.useLeft = null;
    this.useTop = null;
    if (typeof $H(this.options).get("left") != "undefined") {
      this.element.setStyle({left: parseFloat($H(this.options).get("left")) + 'px'});
      this.useLeft = true;
    }
    if (typeof $H(this.options).get("right") != "undefined") {
      this.element.setStyle({right: parseFloat($H(this.options).get("right")) + 'px'});
      this.useLeft = false;
    }
    
    if (typeof $H(this.options).get("top") != "undefined") {
      this.element.setStyle({top: parseFloat($H(this.options).get("top")) + 'px'});
      this.useTop = true;
    }
    if (typeof $H(this.options).get("bottom") != "undefined") {
      this.element.setStyle({bottom: parseFloat($H(this.options).get("bottom")) + 'px'});      
      this.useTop = false;
    }
      
    this.storedLocation = null;
    
    this.setOpacity($H(this.options).get("opacity"));
    if ($H(this.options).get("zIndex"))
      this.setZIndex($H(this.options).get("zIndex"))

    if ($H(this.options).get("destroyOnClose"))
      this.setDestroyOnClose(true);

    this._getWindowBorderSize();
    this.width = $H(this.options).get("width");
    this.height = $H(this.options).get("height");
    this.visible = false;
    
    this.constraint = false;
    this.constraintPad = {top: 0, left:0, bottom:0, right:0};
    
    if (this.width && this.height)
      this.setSize($H(this.options).get("width"), $H(this.options).get("height"));
    this.setTitle($H(this.options).get("title"))
    Windows.register(this);      
  },
  
  // Destructor
  destroy: function() {
    this._notify("onDestroy");
    Event.stopObserving(this.topbar, "mousedown", this.eventMouseDown);
    Event.stopObserving(this.bottombar, "mousedown", this.eventMouseDown);
    Event.stopObserving(this.content, "mousedown", this.eventMouseDownContent);
    
    Event.stopObserving(window, "load", this.eventOnLoad);
    Event.stopObserving(window, "resize", this.eventResize);
    Event.stopObserving(window, "scroll", this.eventResize);
    Event.stopObserving($H(this.options).get("parent"), "scroll", this.eventResize);
    
    Event.stopObserving(this.content, "load", this.options.get("onload"));

    if (this._oldParent) {
      var content = this.getContent();
      var originalContent = null;
      for(var i = 0; i < content.childNodes.length; i++) {
        originalContent = content.childNodes[i];
        if (originalContent.nodeType == 1) 
          break;
        originalContent = null;
      }
      if (originalContent)
        this._oldParent.appendChild(originalContent);
      this._oldParent = null;
    }

    if (this.sizer)
        Event.stopObserving(this.sizer, "mousedown", this.eventMouseDown);

    if (this.options.get("url")) 
      this.content.src = null

    if(this.iefix) { 
    	Element.remove(this.iefix); 
    	this.iefix = null;
		}

//    Element.remove(this.element);
    Windows.unregister(this);      
  },
    
  // Sets close callback, if it sets, it should return true to be able to close the window.
  setCloseCallback: function(callback) {
    this.options.closeCallback = callback;
  },
  
  // Gets window content
  getContent: function () {
    return this.content;
  },
  
  // Sets the content with an element id
  setContent: function(id, autoresize, autoposition) {
    var element = $(id);
    if (null == element) throw "Unable to find element '" + id + "' in DOM";
    this._oldParent = element.parentNode;

    var d = null;
    var p = null;

    if (autoresize) 
      d = Element.getDimensions(element);
    if (autoposition) 
      p = Position.cumulativeOffset(element);

    var content = this.getContent();
    // Clear HTML (and even iframe)
    this.setHTMLContent("");
    content = this.getContent();
    
    content.appendChild(element);
    element.show();
    if (autoresize) 
      this.setSize(d.width, d.height);
    if (autoposition) 
      this.setLocation(p[1] - this.heightN, p[0] - this.widthW);    
  },
  
  setHTMLContent: function(html) {
    // It was an url (iframe), recreate a div content instead of iframe content
    if (this.options.get("url")) {
      this.content.src = null;
      this.options.get("url") = null;
      
  	  var content ="<div id=\"" + this.getId() + "_content\" class=\"" + this.options.get("className") + "_content\"> </div>";
      $(this.getId() +"_table_content").innerHTML = content;
      
      this.content = $(this.element.id + "_content");
    }
      
    this.getContent().innerHTML = html;
  },
  
  setAjaxContent: function(url, options, showCentered, showModal) {
    this.showFunction = showCentered ? "showCenter" : "show";
    this.showModal = showModal || false;
  
    options = options || {};

    // Clear HTML (and even iframe)
    this.setHTMLContent("");
 
    this.onComplete = options.onComplete;
    if (! this._onCompleteHandler)
      this._onCompleteHandler = this._setAjaxContent.bind(this);
    options.onComplete = this._onCompleteHandler;

    new Ajax.Request(url, options);    
    options.onComplete = this.onComplete;
  },
  
  _setAjaxContent: function(originalRequest) {
    Element.update(this.getContent(), originalRequest.responseText);
    if (this.onComplete)
      this.onComplete(originalRequest);
    this.onComplete = null;
    this[this.showFunction](this.showModal)
  },
  
  setURL: function(url) {
    // Not an url content, change div to iframe
    if (this.options.url) 
      this.content.src = null;
    this.options.url = url;
    var content= "<iframe frameborder='0' name='" + this.getId() + "_content'  id='" + this.getId() + "_content' src='" + url + "' width='" + this.width + "' height='" + this.height + "'> </iframe>";
    $(this.getId() +"_table_content").innerHTML = content;
    
    this.content = $(this.element.id + "_content");
  },

  getURL: function() {
  	return this.options.url ? this.options.url : null;
  },

  refresh: function() {
    if (this.options.url)
	    $(this.element.getAttribute('id') + '_content').src = this.options.url;
  },
  
  // Stores position/size in a cookie, by default named with window id
  setCookie: function(name, expires, path, domain, secure) {
    name = name || this.element.id;
    this.cookie = [name, expires, path, domain, secure];
    
    // Get cookie
    var value = WindowUtilities.getCookie(name)
    // If exists
    if (value) {
      var values = value.split(',');
      var x = values[0].split(':');
      var y = values[1].split(':');

      var w = parseFloat(values[2]), h = parseFloat(values[3]);
      var mini = values[4];
      var maxi = values[5];

      this.setSize(w, h);
      if (mini == "true")
        this.doMinimize = true; // Minimize will be done at onload window event
      else if (maxi == "true")
        this.doMaximize = true; // Maximize will be done at onload window event

      this.useLeft = x[0] == "l";
      this.useTop = y[0] == "t";

      this.element.setStyle(this.useLeft ? {left: x[1]} : {right: x[1]});
      this.element.setStyle(this.useTop ? {top: y[1]} : {bottom: y[1]});
    }
  },
  
  // Gets window ID
  getId: function() {
    return this.element.id;
  },
  
  // Detroys itself when closing 
  setDestroyOnClose: function() {
    this.options.set("destroyOnClose", true);
  },
  
  setConstraint: function(bool, padding) {
    this.constraint = bool;
    this.constraintPad = Object.extend(this.constraintPad, padding || {});
    // Reset location to apply constraint
    if (this.useTop && this.useLeft)
      this.setLocation(parseFloat(this.element.style.top), parseFloat(this.element.style.left));
  },
  
  // initDrag event

  _initDrag: function(event) {
    // No resize on minimized window
    if (Event.element(event) == this.sizer && this.isMinimized())
      return;

    // No move on maximzed window
    if (Event.element(event) != this.sizer && this.isMaximized())
      return;
      
    if (Prototype.Browser.IE && this.heightN == 0)
      this._getWindowBorderSize();
    // Get pointer X,Y
    this.pointer = [this._round(Event.pointerX(event), this.options.get("gridX")), this._round(Event.pointerY(event), this.options.get("gridY"))];
    if (this.options.get("wiredDrag")) 
      this.currentDrag = this._createWiredElement();
    else
      this.currentDrag = this.element;
    // Resize
    if (Event.element(event) == this.sizer) {
      this.doResize = true;
      this.widthOrg = this.width;
      this.heightOrg = this.height;
      this.bottomOrg = parseFloat(this.element.getStyle('bottom'));
      this.rightOrg = parseFloat(this.element.getStyle('right'));
      this._notify("onStartResize");
    }
    else {
      this.doResize = false;

      // Check if click on close button, 
      var closeButton = $(this.getId() + '_close');
      if (closeButton && Position.within(closeButton, this.pointer[0], this.pointer[1])) {
        this.currentDrag = null;
        return;
      }
      this.toFront();

      if (! this.options.get("draggable")) 
        return;
      this._notify("onStartMove");
    }    
    // Register global event to capture mouseUp and mouseMove
    Event.observe(document, "mouseup", this.eventMouseUp, false);
    Event.observe(document, "mousemove", this.eventMouseMove, false);
    
    // Add an invisible div to keep catching mouse event over iframes
    WindowUtilities.disableScreen('__invisible__', '__invisible__', this.overlayOpacity);

    // Stop selection while dragging
    document.body.ondrag = function () { return false; };
    document.body.onselectstart = function () { return false; };
    
    this.currentDrag.show();
    Event.stop(event);
  },
  
  _round: function(val, round) {
    return round == 1 ? val  : val = Math.floor(val / round) * round;
  },

  // updateDrag event
  _updateDrag: function(event) {
    var pointer =  [this._round(Event.pointerX(event), this.options.get("gridX")), this._round(Event.pointerY(event), this.options.get("gridY"))];  
    var dx = pointer[0] - this.pointer[0];
    var dy = pointer[1] - this.pointer[1];
    
    // Resize case, update width/height
    if (this.doResize) {
      var w = this.widthOrg + dx;
      var h = this.heightOrg + dy;
      
      dx = this.width - this.widthOrg
      dy = this.height - this.heightOrg
      
      // Check if it's a right position, update it to keep upper-left corner at the same position
      if (this.useLeft) 
        w = this._updateWidthConstraint(w)
      else 
        this.currentDrag.setStyle({right: (this.rightOrg -dx) + 'px'});
      // Check if it's a bottom position, update it to keep upper-left corner at the same position
      if (this.useTop) 
        h = this._updateHeightConstraint(h)
      else
        this.currentDrag.setStyle({bottom: (this.bottomOrg -dy) + 'px'});
      
      this.setSize(w , h);
      this._notify("onResize");
    }
    // Move case, update top/left
    else {
      this.pointer = pointer;
      
      if (this.useLeft) {
        var left =  parseFloat(this.currentDrag.getStyle('left')) + dx;
        var newLeft = this._updateLeftConstraint(left);
        // Keep mouse pointer correct
        this.pointer[0] += newLeft-left;
        this.currentDrag.setStyle({left: newLeft + 'px'});
      }
      else 
        this.currentDrag.setStyle({right: parseFloat(this.currentDrag.getStyle('right')) - dx + 'px'});
      
      if (this.useTop) {
        var top =  parseFloat(this.currentDrag.getStyle('top')) + dy;
        var newTop = this._updateTopConstraint(top);
        // Keep mouse pointer correct
        this.pointer[1] += newTop - top;
        this.currentDrag.setStyle({top: newTop + 'px'});
      }
      else 
        this.currentDrag.setStyle({bottom: parseFloat(this.currentDrag.getStyle('bottom')) - dy + 'px'});

      this._notify("onMove");
    }
    if (this.iefix) 
      this._fixIEOverlapping(); 
      
    this._removeStoreLocation();
    Event.stop(event);
  },

   // endDrag callback
   _endDrag: function(event) {
    // Remove temporary div over iframes
     WindowUtilities.enableScreen('__invisible__');
    
    if (this.doResize)
      this._notify("onEndResize");
    else
      this._notify("onEndMove");
    
    // Release event observing
    Event.stopObserving(document, "mouseup", this.eventMouseUp,false);
    Event.stopObserving(document, "mousemove", this.eventMouseMove, false);

    Event.stop(event);
    
    this._hideWiredElement();

    // Store new location/size if need be
    this._saveCookie()
      
    // Restore selection
    document.body.ondrag = null;
    document.body.onselectstart = null;
  },

  _updateLeftConstraint: function(left) {
    if (this.constraint && this.useLeft && this.useTop) {
      var width = $H(this.options).get("parent") == document.body ? WindowUtilities.getPageSize().windowWidth : $H(this.options).get("parent").getDimensions().width;

      if (left < this.constraintPad.left)
        left = this.constraintPad.left;
      if (left + this.width + this.widthE + this.widthW > width - this.constraintPad.right) 
        left = width - this.constraintPad.right - this.width - this.widthE - this.widthW;
    }
    return left;
  },
  
  _updateTopConstraint: function(top) {
  	if (this.constraint && this.useLeft && this.useTop) {        
     var height = $H(this.options).get("parent") == document.body ? WindowUtilities.getPageSize().windowHeight : $H(this.options).get("parent").getDimensions().height;
        var scroll_top = WindowUtilities.getWindowScroll().top;

      var h = this.height + this.heightN + this.heightS;

      if (top < this.constraintPad.top) top = this.constraintPad.top;
      
      if (top - scroll_top + h > height - this.constraintPad.bottom) {
      	top = height -  this.constraintPad.bottom - h + scroll_top;
      }      
    } 
    return top; 
 },

  
  _updateWidthConstraint: function(w) {
    if (this.constraint && this.useLeft && this.useTop) {
      var width = $H(this.options).get("parent") == document.body ? WindowUtilities.getPageSize().windowWidth : $H(this.options).get("parent").getDimensions().width;
      var left =  parseFloat(this.element.getStyle("left"));

      if (left + w + this.widthE + this.widthW > width - this.constraintPad.right) 
        w = width - this.constraintPad.right - left - this.widthE - this.widthW;
    }
    return w;
  },
  
  _updateHeightConstraint: function(h) {
    if (this.constraint && this.useLeft && this.useTop) {
      var height = $H(this.options).get("parent") == document.body ? WindowUtilities.getPageSize().windowHeight : $H(this.options).get("parent").getDimensions().height;
      var top =  parseFloat(this.element.getStyle("top"));

      if (top + h + this.heightN + this.heightS > height - this.constraintPad.bottom) 
        h = height - this.constraintPad.bottom - top - this.heightN - this.heightS;
    }
    return h;
  },
  
  
  // Creates HTML window code
  _createWindow: function(id) {
    var className = this.options.get("className");
    var win = document.createElement("div");
    win.setAttribute('id', id);
    win.className = "dialog";

    var content;
    if (this.options.get("url"))
      content= "<iframe frameborder=\"0\" name=\"" + id + "_content\"  id=\"" + id + "_content\" src=\"" + this.options.get("url") + "\"> </iframe>";
    else
      content ="<div id=\"" + id + "_content\" class=\"" +className + "_content\"> </div>";

    var closeDiv = this.options.get("closable") ? "<div" + (this.options.get("showBeforeRequest") ? " style='display:none'" : "")+ " class='"+ className +"_close' id='"+ id +"_close' onclick='WindowUtilities.hideModal = true;Windows.close(\""+ id +"\", event)'> </div>" : "";
    var minDiv = this.options.get("minimizable") ? "<div class='"+ className + "_minimize' id='"+ id +"_minimize' onclick='Windows.minimize(\""+ id +"\", event)'> </div>" : "";
    var maxDiv = this.options.get("maximizable") ? "<div class='"+ className + "_maximize' id='"+ id +"_maximize' onclick='Windows.maximize(\""+ id +"\", event)'> </div>" : "";
    var seAttributes = this.options.get("resizable") ? "class='" + className + "_sizer' id='" + id + "_sizer'" : "class='"  + className + "_se'";
    var blank = "../themes/default/blank.gif";
    
    win.innerHTML = closeDiv + minDiv + maxDiv + "\
      <table id='"+ id +"_row1' class=\"top table_window\">\
        <tr>\
          <td class='"+ className +"_nw'></td>\
          <td class='"+ className +"_n'><div id='"+ id +"_top' class='"+ className +"_title title_window'>"+ this.options.get("title") +"</div></td>\
          <td class='"+ className +"_ne'></td>\
        </tr>\
      </table>\
      <table id='"+ id +"_row2' class=\"mid table_window\">\
        <tr>\
          <td class='"+ className +"_w'></td>\
            <td id='"+ id +"_table_content' class='"+ className +"_content' valign='top'>" + content + "</td>\
          <td class='"+ className +"_e'></td>\
        </tr>\
      </table>\
        <table id='"+ id +"_row3' class=\"bot table_window\">\
        <tr>\
          <td class='"+ className +"_sw'></td>\
            <td class='"+ className +"_s'><div id='"+ id +"_bottom' class='status_bar'><span style='float:left; width:1px; height:1px'></span></div></td>\
            <td " + seAttributes + "></td>\
        </tr>\
      </table>\
    ";
    Element.hide(win);
    $H(this.options).get("parent").insertBefore(win, $H(this.options).get("parent").firstChild);
    Event.observe($(id + "_content"), "load", this.options.get("onload"));
    return win;
  },
  
  
  changeClassName: function(newClassName) {    
    var className = this.options.className;
    var id = this.getId();
    $A(["_close", "_minimize", "_maximize", "_sizer", "_content"]).each(function(value) { this._toggleClassName($(id + value), className + value, newClassName + value) }.bind(this));
    this._toggleClassName($(id + "_top"), className + "_title", newClassName + "_title");
    $$("#" + id + " td").each(function(td) {td.className = td.className.sub(className,newClassName); });
    this.options.className = newClassName;
  },
  
  _toggleClassName: function(element, oldClassName, newClassName) { 
    if (element) {
      element.removeClassName(oldClassName);
      element.addClassName(newClassName);
    }
  },
  
  // Sets window location
  setLocation: function(top, left) {
    top = this._updateTopConstraint(top);
    left = this._updateLeftConstraint(left);

    var e = this.currentDrag || this.element;
    e.setStyle({top: top + 'px'});
    e.setStyle({left: left + 'px'});

    this.useLeft = true;
    this.useTop = true;
  },
    
  getLocation: function() {
    var location = {};
    if (this.useTop)
      location = Object.extend(location, {top: this.element.getStyle("top")});
    else
      location = Object.extend(location, {bottom: this.element.getStyle("bottom")});
    if (this.useLeft)
      location = Object.extend(location, {left: this.element.getStyle("left")});
    else
      location = Object.extend(location, {right: this.element.getStyle("right")});
    
    return location;
  },
  
  // Gets window size
  getSize: function() {
    return {width: this.width, height: this.height};
  },
    
  // Sets window size
  setSize: function(width, height, useEffect) {    
    width = parseFloat(width);
    height = parseFloat(height);
    
    // Check min and max size
    if (!this.minimized && width < this.options.get("minWidth"))
      width = this.options.get("minWidth");

    if (!this.minimized && height < this.options.get("minHeight"))
      height = this.options.get("minHeight");
      
    if (this.options.get("maxHeight") && height > this.options.get("maxHeight"))
      height = this.options.get("maxHeight");

    if (this.options.get("maxWidth") && width > this.options.get("maxWidth"))
      width = this.options.get("maxWidth");

    if (this.useTop && this.useLeft && Window.hasEffectLib && Effect.ResizeWindow && useEffect) {
      new Effect.ResizeWindow(this, null, null, width, height, {duration: Window.resizeEffectDuration});
    } else {
      this.width = width;
      this.height = height;
      var e = this.currentDrag ? this.currentDrag : this.element;

      e.setStyle({width: width + this.widthW + this.widthE + "px"})
      e.setStyle({height: height  + this.heightN + this.heightS + "px"})

      // Update content size
      if (!this.currentDrag || this.currentDrag == this.element) {
        var content = $(this.element.id + '_content');
        content.setStyle({height: height  + 'px'});
        content.setStyle({width: width  + 'px'});
      }
    }
  },
  
  updateHeight: function() {
    // WR: make a first (useless) read of scrollHeight to fix a bug in IE 6-7
    this.content.scrollHeight;
    this.setSize(this.width, this.content.scrollHeight, true);
  },
  
  updateWidth: function() {
    this.setSize(this.content.scrollWidth, this.height, true);
  },
  
  // Brings window to front
  toFront: function() {
    if (this.element.style.zIndex < Windows.maxZIndex)  
      this.setZIndex(Windows.maxZIndex + 1);
    if (this.iefix) 
      this._fixIEOverlapping(); 
  },
   
  getBounds: function(insideOnly) {
    if (! this.width || !this.height || !this.visible)  
      this.computeBounds();
    var w = this.width;
    var h = this.height;

    if (!insideOnly) {
      w += this.widthW + this.widthE;
      h += this.heightN + this.heightS;
    }
    var bounds = Object.extend(this.getLocation(), {width: w + "px", height: h + "px"});
    return bounds;
  },
      
  computeBounds: function() {
     if (! this.width || !this.height) {
      var size = WindowUtilities._computeSize(this.content.innerHTML, this.content.id, this.width, this.height, 0, this.options.className)
      if (this.height)
        this.width = size + 5
      else
        this.height = size + 5
    }

    this.setSize(this.width, this.height);
    if (this.centered)
      this._center(this.centerTop, this.centerLeft);    
  },
  
  // Displays window modal state or not
  show: function(modal) {
    this.visible = true;
    if (modal) {
      // Hack for Safari !!
      if (typeof this.overlayOpacity == "undefined") {
        var that = this;
        setTimeout(function() {that.show(modal)}, 10);
        return;
      }
      Windows.addModalWindow(this);
      
      this.modal = true;      
      this.setZIndex(Windows.maxZIndex + 1);
      Windows.unsetOverflow(this);
    }
    else    
      if (!this.element.style.zIndex) 
        this.setZIndex(Windows.maxZIndex + 1);        
      
    // To restore overflow if need be
    if (this.oldStyle)
      this.getContent().setStyle({overflow: this.oldStyle});
      
    this.computeBounds();
    
    // WR: cancel other effects on the same window to avoid races between show's and hide's
	Effect.Queues.instances.each(function(q) {
		q.value.effects.each(function(ef) {
			if (ef.element == this.element) ef.cancel();
		}.bind(this))
	}.bind(this));
    
    this._notify("onBeforeShow");   
    if ($H(this.options).get("showEffect") != Element.show && $H(this.options).get("showEffectOptions"))
      $H(this.options).get("showEffect")(this.element, $H(this.options).get("showEffectOptions"));  
    else
      $H(this.options).get("showEffect")(this.element);  
    this._checkIEOverlapping();
    WindowUtilities.focusedWindow = this
    this._notify("onShow");   
  },
  
  // Displays window modal state or not at the center of the page
  showCenter: function(modal, top, left) {
    this.centered = true;
    this.centerTop = top;
    this.centerLeft = left;

    this.show(modal);
  },
  
  isVisible: function() {
    return this.visible;
  },
  
  _center: function(top, left) {    
    var windowScroll = WindowUtilities.getWindowScroll($H(this.options).get("parent"));    
    var pageSize = WindowUtilities.getPageSize($H(this.options).get("parent"));    
    if (typeof top == "undefined")
      top = (pageSize.windowHeight - (this.height + this.heightN + this.heightS))/2;
    top += windowScroll.top
    
    if (typeof left == "undefined")
      left = (pageSize.windowWidth - (this.width + this.widthW + this.widthE))/2;
    left += windowScroll.left      
    this.setLocation(top, left);
    this.toFront();
  },
  
  _recenter: function(event) {     
    if (this.centered) {
      var pageSize = WindowUtilities.getPageSize($H(this.options).get("parent"));
      var windowScroll = WindowUtilities.getWindowScroll($H(this.options).get("parent"));    

      // Check for this stupid IE that sends dumb events
      if (this.pageSize && this.pageSize.windowWidth == pageSize.windowWidth && this.pageSize.windowHeight == pageSize.windowHeight && 
          this.windowScroll.left == windowScroll.left && this.windowScroll.top == windowScroll.top) 
        return;
      this.pageSize = pageSize;
      this.windowScroll = windowScroll;
      // set height of Overlay to take up whole page and show
      if ($('overlay_modal')) 
        $('overlay_modal').setStyle({height: (pageSize.pageHeight + 'px')});
      
      if (this.options.get("recenterAuto"))
        this._center(this.centerTop, this.centerLeft);    
    }
  },
  
  // Hides window
  hide: function() {
    this.visible = false;
    if (this.modal) {
      Windows.removeModalWindow(this);
      Windows.resetOverflow();
    }
    // To avoid bug on scrolling bar
    this.oldStyle = this.getContent().getStyle('overflow') || "auto"
    this.getContent().setStyle({overflow: "hidden"});

    this.options.get("hideEffect")(this.element, this.options.get("hideEffectOptions"));  

     if(this.iefix) 
      this.iefix.hide();

    if (!this.doNotNotifyHide)
      this._notify("onHide");
  },

  close: function() {
    // Asks closeCallback if exists
    if (this.visible) {
      if (this.options.get("closeCallback") && ! this.options.get("closeCallback")(this)) 
        return;

      if (this.options.get("destroyOnClose")) {
        var destroyFunc = this.destroy.bind(this);
        if (this.options.get("hideEffectOptions").afterFinish) {
          var func = this.options.get("hideEffectOptions").afterFinish;
          this.options.get("hideEffectOptions").afterFinish = function() {func();destroyFunc() }
        }
        else {
        	if (this.options.get("hideEffect") != Element.hide) {
          		this.options.get("hideEffectOptions").afterFinish = function() {destroyFunc() }
          	} else {
          		destroyFunc();
          	}
        }
      }
      Windows.updateFocusedWindow();
      
      this.doNotNotifyHide = true;
      this.hide();
      this.doNotNotifyHide = false;
      this._notify("onClose");
    }
  },
  
  minimize: function() {
    if (this.resizing)
      return;
    
    var r2 = $(this.getId() + "_row2");
    
    if (!this.minimized) {
      this.minimized = true;

      var dh = r2.getDimensions().height;
      this.r2Height = dh;
      var h  = this.element.getHeight() - dh;

      if (this.useLeft && this.useTop && Window.hasEffectLib && Effect.ResizeWindow) {
        new Effect.ResizeWindow(this, null, null, null, this.height -dh, {duration: Window.resizeEffectDuration});
      } else  {
        this.height -= dh;
        this.element.setStyle({height: h + "px"});
        r2.hide();
      }

      if (! this.useTop) {
        var bottom = parseFloat(this.element.getStyle('bottom'));
        this.element.setStyle({bottom: (bottom + dh) + 'px'});
      }
    } 
    else {      
      this.minimized = false;
      
      var dh = this.r2Height;
      this.r2Height = null;
      if (this.useLeft && this.useTop && Window.hasEffectLib && Effect.ResizeWindow) {
        new Effect.ResizeWindow(this, null, null, null, this.height + dh, {duration: Window.resizeEffectDuration});
      }
      else {
        var h  = this.element.getHeight() + dh;
        this.height += dh;
        this.element.setStyle({height: h + "px"})
        r2.show();
      }
      if (! this.useTop) {
        var bottom = parseFloat(this.element.getStyle('bottom'));
        this.element.setStyle({bottom: (bottom - dh) + 'px'});
      }
      this.toFront();
    }
    this._notify("onMinimize");
    
    // Store new location/size if need be
    this._saveCookie()
  },
  
  maximize: function() {
    if (this.isMinimized() || this.resizing)
      return;
  
    if (Prototype.Browser.IE && this.heightN == 0)
      this._getWindowBorderSize();
      
    if (this.storedLocation != null) {
      this._restoreLocation();
      if(this.iefix) 
        this.iefix.hide();
    }
    else {
      this._storeLocation();
      Windows.unsetOverflow(this);
      
      var windowScroll = WindowUtilities.getWindowScroll($H(this.options).get("parent"));
      var pageSize = WindowUtilities.getPageSize($H(this.options).get("parent"));    
      var left = windowScroll.left;
      var top = windowScroll.top;
      
      if ($H(this.options).get("parent") != document.body) {
        windowScroll =  {top:0, left:0, bottom:0, right:0};
        var dim = $H(this.options).get("parent").getDimensions();
        pageSize.windowWidth = dim.width;
        pageSize.windowHeight = dim.height;
        top = 0; 
        left = 0;
      }
      
      if (this.constraint) {
        pageSize.windowWidth -= Math.max(0, this.constraintPad.left) + Math.max(0, this.constraintPad.right);
        pageSize.windowHeight -= Math.max(0, this.constraintPad.top) + Math.max(0, this.constraintPad.bottom);
        left +=  Math.max(0, this.constraintPad.left);
        top +=  Math.max(0, this.constraintPad.top);
      }
      
      var width = pageSize.windowWidth - this.widthW - this.widthE;
      var height= pageSize.windowHeight - this.heightN - this.heightS;

      if (this.useLeft && this.useTop && Window.hasEffectLib && Effect.ResizeWindow) {
        new Effect.ResizeWindow(this, top, left, width, height, {duration: Window.resizeEffectDuration});
      }
      else {
        this.setSize(width, height);
        this.element.setStyle(this.useLeft ? {left: left} : {right: left});
        this.element.setStyle(this.useTop ? {top: top} : {bottom: top});
      }
      this._center();
      this.toFront();
      if (this.iefix) 
        this._fixIEOverlapping(); 
    }
    this._notify("onMaximize");

    // Store new location/size if need be
    this._saveCookie()
  },
  
  isMinimized: function() {
    return this.minimized;
  },
  
  isMaximized: function() {
    return (this.storedLocation != null);
  },
  
  setOpacity: function(opacity) {
    if (Element.setOpacity)
      Element.setOpacity(this.element, opacity);
  },
  
  setZIndex: function(zindex) {
    this.element.setStyle({zIndex: zindex});
    Windows.updateZindex(zindex, this);
  },

  setTitle: function(newTitle) {
    if (!newTitle || newTitle == "") 
      newTitle = "&nbsp;";
      
    Element.update(this.element.id + '_top', newTitle);
  },
   
  getTitle: function() {
    return $(this.element.id + '_top').innerHTML;
  },
  
  setStatusBar: function(element) {
    var statusBar = $(this.getId() + "_bottom");

    if (typeof(element) == "object") {
      if (this.bottombar.firstChild)
        this.bottombar.replaceChild(element, this.bottombar.firstChild);
      else
        this.bottombar.appendChild(element);
    }
    else
      this.bottombar.innerHTML = element;
  },

  _checkIEOverlapping: function() {
	// WR: fix not needed for IE8 #2276
    if(!this.iefix && (navigator.appVersion.indexOf('MSIE')>0) && (navigator.appVersion.indexOf('MSIE 8.0')<0) && (navigator.userAgent.indexOf('Opera')<0) && (this.element.getStyle('position')=='absolute')) {
        new Insertion.After(this.element.id, '<iframe id="' + this.element.id + '_iefix" '+ 'style="display:none;position:absolute;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0);" ' + 'src="javascript:false;" frameborder="0" scrolling="no"></iframe>');
        this.iefix = $(this.element.id+'_iefix');
    }
    if(this.iefix) 
      setTimeout(this._fixIEOverlapping.bind(this), 50);
  },

  _fixIEOverlapping: function() {
      Position.clone(this.element, this.iefix);
      this.iefix.style.zIndex = this.element.style.zIndex - 1;
      this.iefix.show();
  },
  
  _getWindowBorderSize: function(event) {
    // Hack to get real window border size!!
    var div = this._createHiddenDiv(this.options.get("className") + "_n")
    this.heightN = Element.getDimensions(div).height;    
    div.parentNode.removeChild(div)

    var div = this._createHiddenDiv(this.options.get("className") + "_s")
    this.heightS = Element.getDimensions(div).height;    
    div.parentNode.removeChild(div)

    var div = this._createHiddenDiv(this.options.get("className") + "_e")
    this.widthE = Element.getDimensions(div).width;    
    div.parentNode.removeChild(div)

    var div = this._createHiddenDiv(this.options.get("className") + "_w")
    this.widthW = Element.getDimensions(div).width;
    div.parentNode.removeChild(div);
    
    var div = document.createElement("div");
    div.className = "overlay_" + this.options.get("className") ;
    document.body.appendChild(div);
    //alert("no timeout:\nopacity: " + div.getStyle("opacity") + "\nwidth: " + document.defaultView.getComputedStyle(div, null).width);
    var that = this;
    
    // Workaround for Safari!!
    setTimeout(function() {that.overlayOpacity = ($(div).getStyle("opacity")); div.parentNode.removeChild(div);}, 10);
    
    // Workaround for IE!!
    // WR: test for 0 to skip the workaround when not needed (IE 7-8)
    if (Prototype.Browser.IE && (this.heightS == 0 || this.heightN == 0)) {
      this.heightS = $(this.getId() +"_row3").getDimensions().height;
      this.heightN = $(this.getId() +"_row1").getDimensions().height;
    }

    // Safari size fix
    if (Prototype.Browser.WebKit && Prototype.Browser.WebKitVersion < 420)
      this.setSize(this.width, this.height);
    if (this.doMaximize)
      this.maximize();
    if (this.doMinimize)
      this.minimize();
  },
 
  _createHiddenDiv: function(className) {
    var objBody = document.body;
    var win = document.createElement("div");
    win.setAttribute('id', this.element.id+ "_tmp");
    win.className = className;
    win.style.display = 'none';
    win.innerHTML = '';
    objBody.insertBefore(win, objBody.firstChild);
    return win;
  },
  
  _storeLocation: function() {
    if (this.storedLocation == null) {
      this.storedLocation = {useTop: this.useTop, useLeft: this.useLeft, 
                             top: this.element.getStyle('top'), bottom: this.element.getStyle('bottom'),
                             left: this.element.getStyle('left'), right: this.element.getStyle('right'),
                             width: this.width, height: this.height };
    }
  },
  
  _restoreLocation: function() {
    if (this.storedLocation != null) {
      this.useLeft = this.storedLocation.useLeft;
      this.useTop = this.storedLocation.useTop;
      
      if (this.useLeft && this.useTop && Window.hasEffectLib && Effect.ResizeWindow)
        new Effect.ResizeWindow(this, this.storedLocation.top, this.storedLocation.left, this.storedLocation.width, this.storedLocation.height, {duration: Window.resizeEffectDuration});
      else {
        this.element.setStyle(this.useLeft ? {left: this.storedLocation.left} : {right: this.storedLocation.right});
        this.element.setStyle(this.useTop ? {top: this.storedLocation.top} : {bottom: this.storedLocation.bottom});
        this.setSize(this.storedLocation.width, this.storedLocation.height);
      }
      
      Windows.resetOverflow();
      this._removeStoreLocation();
    }
  },
  
  _removeStoreLocation: function() {
    this.storedLocation = null;
  },
  
  _saveCookie: function() {
    if (this.cookie) {
      var value = "";
      if (this.useLeft)
        value += "l:" +  (this.storedLocation ? this.storedLocation.left : this.element.getStyle('left'))
      else
        value += "r:" + (this.storedLocation ? this.storedLocation.right : this.element.getStyle('right'))
      if (this.useTop)
        value += ",t:" + (this.storedLocation ? this.storedLocation.top : this.element.getStyle('top'))
      else
        value += ",b:" + (this.storedLocation ? this.storedLocation.bottom :this.element.getStyle('bottom'))
        
      value += "," + (this.storedLocation ? this.storedLocation.width : this.width);
      value += "," + (this.storedLocation ? this.storedLocation.height : this.height);
      value += "," + this.isMinimized();
      value += "," + this.isMaximized();
      WindowUtilities.setCookie(value, this.cookie)
    }
  },
  
  _createWiredElement: function() {
    if (! this.wiredElement) {
      if (Prototype.Browser.IE)
        this._getWindowBorderSize();
      var div = document.createElement("div");
      div.className = "wired_frame " + this.options.className + "_wired_frame";
      
      div.style.position = 'absolute';
      $H(this.options).get("parent").insertBefore(div, $H(this.options).get("parent").firstChild);
      this.wiredElement = $(div);
    }
    if (this.useLeft) 
      this.wiredElement.setStyle({left: this.element.getStyle('left')});
    else 
      this.wiredElement.setStyle({right: this.element.getStyle('right')});
      
    if (this.useTop) 
      this.wiredElement.setStyle({top: this.element.getStyle('top')});
    else 
      this.wiredElement.setStyle({bottom: this.element.getStyle('bottom')});

    var dim = this.element.getDimensions();
    this.wiredElement.setStyle({width: dim.width + "px", height: dim.height +"px"});

    this.wiredElement.setStyle({zIndex: Windows.maxZIndex+30});
    return this.wiredElement;
  },
  
  _hideWiredElement: function() {
    if (! this.wiredElement || ! this.currentDrag)
      return;
    if (this.currentDrag == this.element) 
      this.currentDrag = null;
    else {
      if (this.useLeft) 
        this.element.setStyle({left: this.currentDrag.getStyle('left')});
      else 
        this.element.setStyle({right: this.currentDrag.getStyle('right')});

      if (this.useTop) 
        this.element.setStyle({top: this.currentDrag.getStyle('top')});
      else 
        this.element.setStyle({bottom: this.currentDrag.getStyle('bottom')});

      this.currentDrag.hide();
      this.currentDrag = null;
      if (this.doResize)
        this.setSize(this.width, this.height);
    } 
  },
  
  _notify: function(eventName) {
    if (this.options[eventName])
      this.options[eventName](this);
    else
      Windows.notify(eventName, this);
  }
};

// Windows containers, register all page windows
var Windows = {
  windows: [],
  modalWindows: [],
  observers: [],
  focusedWindow: null,
  maxZIndex: 0,
  overlayShowEffectOptions: {duration: 0.5},
  overlayHideEffectOptions: {duration: 0.5},

  addObserver: function(observer) {
    this.removeObserver(observer);
    this.observers.push(observer);
  },
  
  removeObserver: function(observer) {  
    this.observers = this.observers.reject( function(o) { return o==observer });
  },
  
  // onDestroy onStartResize onStartMove onResize onMove onEndResize onEndMove onFocus onBlur onBeforeShow onShow onHide onMinimize onMaximize onClose
  notify: function(eventName, win) {  
    this.observers.each( function(o) {if(o[eventName]) o[eventName](eventName, win);});
  },

  // Gets window from its id
  getWindow: function(id) {
    return this.windows.detect(function(d) { return d.getId() ==id });
  },

  // Gets the last focused window
  getFocusedWindow: function() {
    return this.focusedWindow;
  },

  updateFocusedWindow: function() {
   //WR: modified 2 to 1
    this.focusedWindow = this.windows.length >=1 ? this.windows[this.windows.length - 2] : null;    
  },
  
  // Registers a new window (called by Windows constructor)
  register: function(win) {
    this.windows.push(win);
  },
    
  // Add a modal window in the stack
  addModalWindow: function(win) {
    // Disable screen if first modal window
    if (this.modalWindows.length == 0) {
      WindowUtilities.disableScreen(win.options.get("className"), 'overlay_modal', win.overlayOpacity, win.getId(), win.options.get("parent"));
    }
    else {
      // Move overlay over all windows
      if (Window.keepMultiModalWindow) {
        $('overlay_modal').style.zIndex = Windows.maxZIndex + 1;
        Windows.maxZIndex += 1;
        WindowUtilities._hideSelect(this.modalWindows.last().getId());
      }
      // Hide current modal window
      else
        this.modalWindows.last().element.hide();
      // Fucking IE select issue
      WindowUtilities._showSelect(win.getId());
    }      
    this.modalWindows.push(win);    
  },
  
  removeModalWindow: function(win) {
    this.modalWindows.pop();
    
    // No more modal windows
    if (this.modalWindows.length == 0)
      WindowUtilities.enableScreen();     
    else {
      if (Window.keepMultiModalWindow) {
        this.modalWindows.last().toFront();
        WindowUtilities._showSelect(this.modalWindows.last().getId());        
      }
      else
        this.modalWindows.last().element.show();
    }
  },
  
  // Registers a new window (called by Windows constructor)
  register: function(win) {
    this.windows.push(win);
  },
  
  // Unregisters a window (called by Windows destructor)
  unregister: function(win) {
    this.windows = this.windows.reject(function(d) { return d==win });
  }, 
  
  // Closes all windows
  closeAll: function() {  
    this.windows.each( function(w) {Windows.close(w.getId())} );
  },
  
  closeAllModalWindows: function() {
    WindowUtilities.enableScreen();     
    this.modalWindows.each( function(win) {if (win) win.close()});    
  },

  // Minimizes a window with its id
  minimize: function(id, event) {
    var win = this.getWindow(id)
    if (win && win.visible)
      win.minimize();
    Event.stop(event);
  },
  
  // Maximizes a window with its id
  maximize: function(id, event) {
    var win = this.getWindow(id)
    if (win && win.visible)
      win.maximize();
    Event.stop(event);
  },

  // Closes a window with its id
  close: function(id, event) {
    var win = this.getWindow(id);
    if (win) 
      win.close();
    if (event)
      Event.stop(event);
  },
  
  blur: function(id) {
    var win = this.getWindow(id);  
    if (!win)
      return;
    if (win.options.get("blurClassName"))
      win.changeClassName(win.options.get("blurClassName"));
    if (this.focusedWindow == win)  
      this.focusedWindow = null;
    win._notify("onBlur");  
  },
  
  focus: function(id) {
    var win = this.getWindow(id);  
    if (!win)
      return;       
    if (this.focusedWindow)
      this.blur(this.focusedWindow.getId())

    if (win.options.focusClassName)
      win.changeClassName(win.options.get("focusClassName"));  
    this.focusedWindow = win;
    win._notify("onFocus");
  },
  
  unsetOverflow: function(except) {    
	// WR: retain oldOverflow #2275
    this.windows.each(function(d) { d.oldOverflow = d.oldOverflow || d.getContent().getStyle("overflow") || "auto" ; d.getContent().setStyle({overflow: "hidden"}) });
    if (except && except.oldOverflow)
      except.getContent().setStyle({overflow: except.oldOverflow});
  },

  resetOverflow: function() {
    this.windows.each(function(d) { if (d.oldOverflow) d.getContent().setStyle({overflow: d.oldOverflow}) });
  },

  updateZindex: function(zindex, win) { 
    if (zindex > this.maxZIndex) {   
      this.maxZIndex = zindex;    
      if (this.focusedWindow) 
        this.blur(this.focusedWindow.getId())
    }
    this.focusedWindow = win;
    if (this.focusedWindow) 
      this.focus(this.focusedWindow.getId())
  }
};

var Dialog = {
  dialogId: null,
  onCompleteFunc: null,
  callFunc: null, 
  parameters: null, 
    
  confirm: function(content, parameters) {
    // Get Ajax return before
    if (content && typeof content != "string") {
      Dialog._runAjaxRequest(content, parameters, Dialog.confirm);
      return 
    }
    content = content || "";
    
    parameters = parameters || {};
    var okLabel = parameters.okLabel ? parameters.okLabel : "Ok";
    var cancelLabel = parameters.cancelLabel ? parameters.cancelLabel : "Cancel";

    // Backward compatibility
    parameters = Object.extend(parameters, parameters.windowParameters || {});
    parameters.windowParameters = parameters.windowParameters || {};

    parameters.className = parameters.className || "alert";

    var okButtonClass = "class ='" + (parameters.buttonClass ? parameters.buttonClass + " " : "") + " ok_button'" 
    var cancelButtonClass = "class ='" + (parameters.buttonClass ? parameters.buttonClass + " " : "") + " cancel_button'" 
    var content = "\
      <div class='" + parameters.className + "_message'>" + content  + "</div>\
        <div class='" + parameters.className + "_buttons'>\
          <input type='button' value='" + okLabel + "' onclick='Dialog.okCallback()' " + okButtonClass + "/>\
          <input type='button' value='" + cancelLabel + "' onclick='Dialog.cancelCallback()' " + cancelButtonClass + "/>\
        </div>\
    ";
    return this._openDialog(content, parameters)
  },
  
  alert: function(content, parameters) {
    // Get Ajax return before
    if (content && typeof content != "string") {
      Dialog._runAjaxRequest(content, parameters, Dialog.alert);
      return 
    }
    content = content || "";
    
    parameters = parameters || {};
    var okLabel = parameters.okLabel ? parameters.okLabel : "Ok";

    // Backward compatibility    
    parameters = Object.extend(parameters, parameters.windowParameters || {});
    parameters.windowParameters = parameters.windowParameters || {};
    
    parameters.className = parameters.className || "alert";
    
    var okButtonClass = "class ='" + (parameters.buttonClass ? parameters.buttonClass + " " : "") + " ok_button'" 
    var content = "\
      <div class='" + parameters.className + "_message'>" + content  + "</div>\
        <div class='" + parameters.className + "_buttons'>\
          <input type='button' value='" + okLabel + "' onclick='Dialog.okCallback()' " + okButtonClass + "/>\
        </div>";                  
    return this._openDialog(content, parameters)
  },
  
  info: function(content, parameters) {   
    // Get Ajax return before
    if (content && typeof content != "string") {
      Dialog._runAjaxRequest(content, parameters, Dialog.info);
      return 
    }
    content = content || "";
     
    // Backward compatibility
    parameters = parameters || {};
    parameters = Object.extend(parameters, parameters.windowParameters || {});
    parameters.windowParameters = parameters.windowParameters || {};
    
    parameters.className = parameters.className || "alert";
    
    var content = "<div id='modal_dialog_message' class='" + parameters.className + "_message'>" + content  + "</div>";
    if (parameters.showProgress)
      content += "<div id='modal_dialog_progress' class='" + parameters.className + "_progress'>  </div>";

    parameters.ok = null;
    parameters.cancel = null;
    
    return this._openDialog(content, parameters)
  },
  
  setInfoMessage: function(message) {
    $('modal_dialog_message').update(message);
  },
  
  closeInfo: function() {
    Windows.close(this.dialogId);
  },
  
  _openDialog: function(content, parameters) {
    var className = parameters.className;
    
    if (! parameters.height && ! parameters.width) {
      parameters.width = WindowUtilities.getPageSize(parameters.options.parent || document.body).pageWidth / 2;
    }
    if (parameters.id)
      this.dialogId = parameters.id;
    else { 
      var t = new Date();
      this.dialogId = 'modal_dialog_' + t.getTime();
      parameters.id = this.dialogId;
    }

    // compute height or width if need be
    if (! parameters.height || ! parameters.width) {
      var size = WindowUtilities._computeSize(content, this.dialogId, parameters.width, parameters.height, 5, className)
      if (parameters.height)
        parameters.width = size + 5
      else
        parameters.height = size + 5
    }
    parameters.effectOptions = parameters.effectOptions ;
    parameters.resizable   = parameters.resizable || false;
    parameters.minimizable = parameters.minimizable || false;
    parameters.maximizable = parameters.maximizable ||  false;
    parameters.draggable   = parameters.draggable || false;
    parameters.closable    = parameters.closable || false;
    
    var win = new Window(parameters);
    win.getContent().innerHTML = content;
    
    win.showCenter(true, parameters.top, parameters.left);  
    win.setDestroyOnClose();
    
    win.cancelCallback = parameters.onCancel || parameters.cancel; 
    win.okCallback = parameters.onOk || parameters.ok;
    
    return win;    
  },
  
  _getAjaxContent: function(originalRequest)  {
      Dialog.callFunc(originalRequest.responseText, Dialog.parameters)
  },
  
  _runAjaxRequest: function(message, parameters, callFunc) {
    if (message.options == null)
      message.options = {}  
    Dialog.onCompleteFunc = message.options.onComplete;
    Dialog.parameters = parameters;
    Dialog.callFunc = callFunc;
    
    message.options.onComplete = Dialog._getAjaxContent;
    new Ajax.Request(message.url, message.options);
  },
  
  okCallback: function() {
    var win = Windows.focusedWindow;
    if (!win.okCallback || win.okCallback(win)) {
      // Remove onclick on button
      $$("#" + win.getId()+" input").each(function(element) {element.onclick=null;})
      win.close();
    }
  },

  cancelCallback: function() {
    var win = Windows.focusedWindow;
    // Remove onclick on button
    $$("#" + win.getId()+" input").each(function(element) {element.onclick=null})
    win.close();
    if (win.cancelCallback)
      win.cancelCallback(win);
  }
}
/*
  Based on Lightbox JS: Fullsize Image Overlays 
  by Lokesh Dhakar - http://www.huddletogether.com

  For more information on this script, visit:
  http://huddletogether.com/projects/lightbox/

  Licensed under the Creative Commons Attribution 2.5 License - http://creativecommons.org/licenses/by/2.5/
  (basically, do anything you want, just leave my name and link)
*/

if (Prototype.Browser.WebKit) {
  var array = navigator.userAgent.match(new RegExp(/AppleWebKit\/([\d\.\+]*)/));
  Prototype.Browser.WebKitVersion = parseFloat(array[1]);
}

var WindowUtilities = {  
	// WR: change for modal windows
	hideModal:true, 
  // From dragdrop.js
  getWindowScroll: function(parent) {
    var T, L, W, H;
    parent = parent || document.body;              
    if (parent != document.body) {
      T = parent.scrollTop;
      L = parent.scrollLeft;
      W = parent.scrollWidth;
      H = parent.scrollHeight;
    } 
    else {
      var w = window;
      with (w.document) {
        if (w.document.documentElement && documentElement.scrollTop) {
          T = documentElement.scrollTop;
          L = documentElement.scrollLeft;
        } else if (w.document.body) {
          T = body.scrollTop;
          L = body.scrollLeft;
        }
        if (w.innerWidth) {
          W = w.innerWidth;
          H = w.innerHeight;
        } else if (w.document.documentElement && documentElement.clientWidth) {
          W = documentElement.clientWidth;
          H = documentElement.clientHeight;
        } else {
          W = body.offsetWidth;
          H = body.offsetHeight
        }
      }
    }
    return { top: T, left: L, width: W, height: H };
  }, 
  //
  // getPageSize()
  // Returns array with page width, height and window width, height
  // Core code from - quirksmode.org
  // Edit for Firefox by pHaez
  //
  getPageSize: function(parent){
    parent = parent || document.body;              
    var windowWidth, windowHeight;
    var pageHeight, pageWidth;
    if (parent != document.body) {
      windowWidth = parent.getWidth();
      windowHeight = parent.getHeight();                                
      pageWidth = parent.scrollWidth;
      pageHeight = parent.scrollHeight;                                
    } 
    else {
      var xScroll, yScroll;

      if (window.innerHeight && window.scrollMaxY) {  
        xScroll = document.body.scrollWidth;
        yScroll = window.innerHeight + window.scrollMaxY;
      } else if (document.body.scrollHeight > document.body.offsetHeight){ // all but Explorer Mac
        xScroll = document.body.scrollWidth;
        yScroll = document.body.scrollHeight;
      } else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
        xScroll = document.body.offsetWidth;
        yScroll = document.body.offsetHeight;
      }


      if (self.innerHeight) {  // all except Explorer
        windowWidth = self.innerWidth;
        windowHeight = self.innerHeight;
      } else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
        windowWidth = document.documentElement.clientWidth;
        windowHeight = document.documentElement.clientHeight;
      } else if (document.body) { // other Explorers
        windowWidth = document.body.clientWidth;
        windowHeight = document.body.clientHeight;
      }  

      // for small pages with total height less then height of the viewport
      if(yScroll < windowHeight){
        pageHeight = windowHeight;
      } else { 
        pageHeight = yScroll;
      }

      // for small pages with total width less then width of the viewport
      if(xScroll < windowWidth){  
        pageWidth = windowWidth;
      } else {
        pageWidth = xScroll;
      }
    }             
    return {pageWidth: pageWidth ,pageHeight: pageHeight , windowWidth: windowWidth, windowHeight: windowHeight};
  },

  disableScreen: function(className, overlayId, overlayOpacity, contentId, parent) {
  	// WR: change for modal windows
  	if (WindowUtilities.hideModal) {
    WindowUtilities.initLightbox(overlayId, className, function() {this._disableScreen(className, overlayId, overlayOpacity, contentId)}.bind(this), parent || document.body);
    }
  },

  _disableScreen: function(className, overlayId, overlayOpacity, contentId) {
    // prep objects
    var objOverlay = $(overlayId);

    var pageSize = WindowUtilities.getPageSize(objOverlay.parentNode);

    // Hide select boxes as they will 'peek' through the image in IE, store old value
    //WebRatio: rmoved for selection fields
    /*if (contentId && Prototype.Browser.IE) {
      WindowUtilities._hideSelect();
      WindowUtilities._showSelect(contentId);
    } */ 
  
    // set height of Overlay to take up whole page and show
    objOverlay.style.height = (pageSize.pageHeight + 'px');
    objOverlay.style.display = 'none'; 
    if (overlayId == "overlay_modal" && Window.hasEffectLib && Windows.overlayShowEffectOptions) {
      objOverlay.overlayOpacity = overlayOpacity;
      new Effect.Appear(objOverlay, Object.extend({from: 0, to: overlayOpacity}, Windows.overlayShowEffectOptions));
    }
    else
      objOverlay.style.display = "block";
  },
  
  enableScreen: function(id) {
  	// WR: change for modal windows
  	if (WindowUtilities.hideModal) {
			id = id || 'overlay_modal';
			var objOverlay =  $(id);
			if (objOverlay) {
				// hide lightbox and overlay
				if (id == "overlay_modal" && Window.hasEffectLib && Windows.overlayHideEffectOptions)
					new Effect.Fade(objOverlay, Object.extend({from: objOverlay.overlayOpacity, to:0}, Windows.overlayHideEffectOptions));
				else {
					objOverlay.style.display = 'none';
					objOverlay.parentNode.removeChild(objOverlay);
				}
				
				// make select boxes visible using old value
				if (id != "__invisible__") 
					WindowUtilities._showSelect();
			}
    }
  },

  _hideSelect: function(id) {
    if (Prototype.Browser.IE) {
      id = id ==  null ? "" : "#" + id + " ";
      $$(id + 'select').each(function(element) {
        if (! WindowUtilities.isDefined(element.oldVisibility)) {
          element.oldVisibility = element.style.visibility ? element.style.visibility : "visible";
          element.style.visibility = "hidden";
        }
      });
    }
  },
  
  _showSelect: function(id) {
    if (Prototype.Browser.IE) {
      id = id ==  null ? "" : "#" + id + " ";
      $$(id + 'select').each(function(element) {
        if (WindowUtilities.isDefined(element.oldVisibility)) {
          // Why?? Ask IE
          try {
            element.style.visibility = element.oldVisibility;
          } catch(e) {
            element.style.visibility = "visible";
          }
          element.oldVisibility = null;
        }
        else {
          if (element.style.visibility)
            element.style.visibility = "visible";
        }
      });
    }
  },

  isDefined: function(object) {
    return typeof(object) != "undefined" && object != null;
  },
  
  // initLightbox()
  // Function runs on window load, going through link tags looking for rel="lightbox".
  // These links receive onclick events that enable the lightbox display for their targets.
  // The function also inserts html markup at the top of the page which will be used as a
  // container for the overlay pattern and the inline image.
  initLightbox: function(id, className, doneHandler, parent) {
    // Already done, just update zIndex
    if ($(id)) {
      Element.setStyle(id, {zIndex: Windows.maxZIndex + 1});
      Windows.maxZIndex++;
      doneHandler();
    }
    // create overlay div and hardcode some functional styles (aesthetic styles are in CSS file)
    else {
      var objOverlay = document.createElement("div");
      objOverlay.setAttribute('id', id);
      objOverlay.className = "overlay_" + className
      objOverlay.style.display = 'none';
      objOverlay.style.position = 'absolute';
      objOverlay.style.top = '0';
      objOverlay.style.left = '0';
      objOverlay.style.zIndex = Windows.maxZIndex + 1;
      Windows.maxZIndex++;
      // WEBRATIO: FIX FOUND ON FORUM FOR WIDTH AND HEIGHT 100%
      //objOverlay.style.width = '100%';
      var pageSize = WindowUtilities.getPageSize(parent); 
      objOverlay.style.width = (pageSize.pageWidth + 'px');     
      parent.insertBefore(objOverlay, parent.firstChild);
      if (Prototype.Browser.WebKit && id == "overlay_modal") {
        setTimeout(function() {doneHandler()}, 10);
      }
      else
        doneHandler();
    }    
  },
  
  setCookie: function(value, parameters) {
    document.cookie= parameters[0] + "=" + escape(value) +
      ((parameters[1]) ? "; expires=" + parameters[1].toGMTString() : "") +
      ((parameters[2]) ? "; path=" + parameters[2] : "") +
      ((parameters[3]) ? "; domain=" + parameters[3] : "") +
      ((parameters[4]) ? "; secure" : "");
  },

  getCookie: function(name) {
    var dc = document.cookie;
    var prefix = name + "=";
    var begin = dc.indexOf("; " + prefix);
    if (begin == -1) {
      begin = dc.indexOf(prefix);
      if (begin != 0) return null;
    } else {
      begin += 2;
    }
    var end = document.cookie.indexOf(";", begin);
    if (end == -1) {
      end = dc.length;
    }
    return unescape(dc.substring(begin + prefix.length, end));
  },
    
  _computeSize: function(content, id, width, height, margin, className) {
    var objBody = document.body;
    var tmpObj = document.createElement("div");
    tmpObj.setAttribute('id', id);
    tmpObj.className = className + "_content";

    if (height)
      tmpObj.style.height = height + "px"
    else
      tmpObj.style.width = width + "px"
  
    tmpObj.style.position = 'absolute';
    tmpObj.style.top = '0';
    tmpObj.style.left = '0';
    tmpObj.style.display = 'none';

    tmpObj.innerHTML = content;
    objBody.insertBefore(tmpObj, objBody.firstChild);

    var size;
    if (height)
      size = $(tmpObj).getDimensions().width + margin;
    else
      size = $(tmpObj).getDimensions().height + margin;
    objBody.removeChild(tmpObj);
    return size;
  }  
}

