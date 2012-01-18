/**
 * Queue for holding AJAX requests and executing them in sequence.
 */
WRAjaxRequestQueue = Class.create({

	initialize: function(options) {
		this.options = {};
		
		Object.extend(this.options, options || {});
		
		this.requests = [];
		this.flow = false;
		
		this.stackCount = 0;
	},

	add: function(obj) {
		if (!(obj instanceof WRAjaxRequestQueue.DTO)) {
			throw { message: "Error creating request" };
		}
		this.requests.push(obj);
	},

    submitForm: function(form, button) {
    	this.add(new WRAjaxRequestQueue.DTO(form, { button: button }));
    	this.start();
    },
    
	start: function() {
		if (this.flow) return false;
		this.flow = true;
		this._send();
	},

	_send: function() {
		var obj = this.requests.shift();
		this.sendRequest(obj);
	},

	_receiveRequest: function() {
		if (this.requests.length == 0) {
			this.flow = false;
		} else {
			this._send();
		}
	},

	sendRequest: function(dto) {
		if (dto.url) {
			var options = {
				onComplete: this._receiveRequest.bind(this)
			}
			Object.extend(options, dto.options || {});
			var form = $(options.formName);
			if (form && form.getInputs("file").size() > 0) {
				new WRAjax.FrameRequest(dto.url, options);
			} else {
				new Ajax.Request(dto.url, options);
			}
		} else {
			dto.form.submitWithButton(dto.options.button);
			this._receiveRequest();
		}
	},

	remove: function(obj) {
		if (!(obj instanceof WRAjaxRequestQueue.DTO)) {
			throw { message: "Error removing request" };
		}
		this.requests.remove(obj);
	}

});

/**
 * An element of a request queue.
 */
WRAjaxRequestQueue.DTO = Class.create({

	initialize: function(item, options) {
		if (item.tagName === "FORM") {
			this.form = item;
		} else {
			this.url = item;
		}
		this.options = options;
	}

});
