function ajaxRequest(url, options) {
	var wrAjaxRequest = new WRAjaxRequest(url, options)
	wrAjaxRequest.sendRequest()
	return false;
}

if (typeof WRAjax == "undefined") {
	var WRAjax = {}
}

WRAjax.messages = {};
