Controller.ready("share", function() {
	// Resize Handler
	(function() {
		var handleResize = function() {
			var topHeight = $("#write-title").outerHeight();
			var bottomHeight = $("#navigation-bar").outerHeight();
			var totalHeight = window.innerHeight;
			var totalWidth = window.innerWidth;
			
			$("#write-body").css({
				top: topHeight,
				height: totalHeight - topHeight - bottomHeight,
				//width: totalWidth - 4
			});
		};
		
		$(window).resize(handleResize);
		handleResize();
	})();
	
	// Document
	var Document = new (function() {
		var $content;
		var $words;
		var contentValue;
		var goal;
		
		this.initialize = function() {
			$content = $("#write-body");
			$words = $("#document-words-current");
			
			contentValue = $content.val();
			goal = parseInt($words.data("goal"));
			
			updateWordDisplay();
		};
		
		var countWords = function(words) {
			return !words ? 0 : words.match(/[^\s]+/g).length;
		};
		
		var updateWordDisplay = function() {
			var numWords = countWords($content.val());
			var color = calculateWordColor(numWords, goal);
			$words.text(numWords).css("color", color);
		};
		
		var calculateWordColor = function(words, goal) {
			return calculateColor(words / goal);
		};
		
		var calculateColor = function(progress) {
			if (progress > 1) {
				progress = 1;
			}
			var redProgress = progress < 0.5 ? 1 : 1 - ((progress - 0.5) * 2);
			var greenProgress = progress > 0.5 ? 1 : progress * 2;
			var redHex = Math.floor(redProgress * 255).toString(16);
			var greenHex = Math.floor(greenProgress * 255).toString(16);
			var blueHex = "00";
			return "#" + (redHex.length == 1 ? "0" + redHex : redHex) + (greenHex.length == 1 ? "0" + greenHex : greenHex) + blueHex;
		};
		
		this.initialize();
	})();
});
