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
	
	var Document = new (function(contentField, saveField, wordsField) {
		var UPDATE_DELAY = 500; // ms
		
		var $content;
		var $save;
		var $words;
		var contentValue;
		var timer;
		
		this.initialize = function() {
			$content = contentField;
			$save = saveField;
			$words = wordsField;
			$content.on("keyup paste", onChange);
		};
		
		var countWords = function(words) {
			return words.split(/\s+/).length;
		};
		
		var onChange = function(event) {
			if (timer) {
				clearTimeout(timer);
			}
			timer = setTimeout(postContent, UPDATE_DELAY);
			updateWordDisplay();
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
			$words.text(countWords($content.val()));
		};
		
		this.initialize();
	})($("#write-body"), $("#save-display"), $("#document-words-current"));
});
