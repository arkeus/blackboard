;(function($) {
	$.fn.edit = function(options) {
		return this.each(function() {
			var element = this, $element = $(element);
			var submitPath = $element.data("submit-path");
			var submitName = $element.data("submit-name");
			var originalValue = $element.text();
			var blurred = false;
			
			var $editBox = $("<input>").attr({
				type: "text",
				value: originalValue,
				'class': $element.attr("class"),
				maxlength: 50
			});
			
			$element.replaceWith($editBox);
			$editBox.focus();
			
			$editBox.blur(function() {
				if (blurred) {
					return;
				}
				blurred = true;
				$editBox.prop("disabled", true);
				
				var data = {};
				data[submitName] = $editBox.val();
				
				trace(submitPath);
				$.ajax({
					type: "PUT",
					data: data,
					url: submitPath
				}).done(function() {
					$element.text($editBox.val());
				}).fail(function() {
					trace("fail");
					// reverts to original value
				}).always(function() {
					trace("always");
					$editBox.replaceWith($element);
				});
			}).keydown(function(event) {
				if (event.which == 13) {
					$(this).blur();
				}
			});
			
		});
	};
})(jQuery);
