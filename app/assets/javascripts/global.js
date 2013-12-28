var Controller = (function() {
	var module = {};
	
	module.ready = function(controllerName, onReady) {
		if (controllerName === window.controller) {
			$(onReady);
		}
	};
	
	return module;
})();

var trace = function(message) {
	console.info(message);
};
