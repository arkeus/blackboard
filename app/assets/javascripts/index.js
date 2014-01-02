Controller.ready("index", function() {
	$("#register-button").click(function() {
		$(this).css("visibility", "hidden");
		$("#registration-fields").slideDown();
		$("#password_confirmation").focus();
	});
	
	$("#register-form").submit(function() {
		$("#register-username").val($("#username").val());
		$("#register-password").val($("#password").val());
	});
	
	$("#register-time-zone").val(jstz.determine().name());
});
