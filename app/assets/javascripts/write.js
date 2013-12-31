Controller.ready("write", function() {
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
				width: totalWidth - 4
			});
		};
		
		$(window).resize(handleResize);
		handleResize();
	})();
	
	// Editable Handler
	(function() {
		$("#write-title").on("click", "#document-title", function() {
			$(this).edit();
		});
	})();
	
	// Document
	var Document = new (function() {
		var UPDATE_DELAY = 5000; // ms
		
		var $content;
		var $save;
		var $words;
		var $goal;
		var contentValue;
		var timer;
		var saving = false;
		
		this.initialize = function() {
			$content = $("#write-body");
			$save = $("#save-display");
			$words = $("#document-words-current");
			$goal = $("#document-words-goal");
			
			initializeCalendarBorders();
			
			contentValue = $content.val();
			$content.on("keyup paste", onChange);
			
			updateWordDisplay();
		};
		
		this.save = function() {
			postContent();
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
			if ($content.val() === contentValue || saving) {
				return;
			}
			saving = true;
			$.ajax({
				url: $content.data("update-path"),
				method: "PUT",
				data: { content: $content.val() },
				async: false
			}).done(function() {
				trace("Saved");
				updateSaveDisplay();
				$save.removeClass("unsaved");
				contentValue = $content.val();
			}).fail(function() {
				trace("Failed to save");
			}).always(function() {
				saving = false;
			});
		};
		
		var updateSaveDisplay = function() {
			$save.find(".timestamp").livestamp(new Date);
		};
		
		var updateWordDisplay = function() {
			var numWords = countWords($content.val());
			var color = calculateWordColor(numWords, parseInt($goal.text()));
			$words.text(numWords).css("color", color);
			$(".calendar-day.selected").parent().css("borderColor", color);
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
	
	// Nav Bar Fader
	(function() {
		var timer;
		var $nav = $("#navigation-bar");
		
		var setFadeoutTimer = function() {
			timer = setTimeout(function() {
				$nav.fadeOut(2000);
			}, 10000);
		};
		
		$(window).on("mousemove", function() {
			if (timer) {
				clearTimeout(timer);
			}
			$nav.fadeIn();
			setFadeoutTimer();
		});
		
		setFadeoutTimer();
	})();
	
	// Other bindings
	(function() {
		// control+s
		$(window).on("keydown", function(event) {
			if (((event.which == 115 || event.which == 83) && event.ctrlKey) || event.which == 19) {
				event.preventDefault();
				Document.save();
			}
		});
		// save on page leave
		$(window).unload(Document.save);
	})();
});
