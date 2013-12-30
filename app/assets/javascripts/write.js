Controller.ready("write", function() {
	var handleResize = function() {
		var topHeight = $("#write-title").outerHeight();
		var bottomHeight = $("#navigation-bar").outerHeight();
		var totalHeight = window.innerHeight;
		var totalWidth = window.innerWidth;
		
		$("#write-body").css({
			top: topHeight,
			height: totalHeight - topHeight - bottomHeight,
			width: totalWidth - 4
		});
	};
	
	$(window).resize(handleResize);
	handleResize();
	
	$("#write-title").on("click", "#document-title", function() {
		$(this).edit();
	});
	
	var Document = new (function() {
		var UPDATE_DELAY = 500; // ms
		
		var $content;
		var $save;
		var $words;
		var $goal;
		var contentValue;
		var timer;
		
		this.initialize = function() {
			$content = $("#write-body");
			$save = $("#save-display");
			$words = $("#document-words-current");
			$goal = $("#document-words-goal");
			
			initializeCalendarBorders();
			
			contentValue = $content.val();
			$content.on("keyup paste", onChange);
			
			//updateSaveDisplay();
			updateWordDisplay();
		};
		
		var countWords = function(words) {
			return !words ? 0 : words.match(/[^\s]+/g).length;
		};
		
		var onChange = function(event) {
			if (timer) {
				clearTimeout(timer);
			}
			timer = setTimeout(postContent, UPDATE_DELAY);
			updateWordDisplay();
			$save.addClass("unsaved");
		};
		
		var postContent = function() {
			if ($content.val() === contentValue) {
				return;
			}
			contentValue = $content.val();
			console.log(countWords($content.val()));
			$.ajax({
				url: $content.data("update-path"),
				method: "PUT",
				data: { content: contentValue }
			}).done(function() {
				updateSaveDisplay();
				$save.removeClass("unsaved");
			}).fail(function() {
				trace("fail");
			}).always(function() {
				trace("always");
			});
		};
		
		var updateSaveDisplay = function() {
			$save.find(".timestamp").livestamp(new Date);
		};
		
		var updateWordDisplay = function() {
			var numWords = countWords($content.val());
			var color = calculateWordColor(numWords, parseInt($goal.text()));
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
		
		var initializeCalendarBorders = function() {
			$("[data-progress]").each(function() {
				var element = this, $element = $(element);
				var color = calculateColor($element.data("progress"));
				$element.css("borderColor", color);
			});
		};
		
		this.initialize();
	})();
});
