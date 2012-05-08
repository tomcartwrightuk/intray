// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
	$('#add_note').hide();
	$('#noteheading').hide();
	$('#addnotebutton').click(function() {
		$('#add_note').show(300);
		$('#noteheading').show(200);
		$('#addnotebutton').hide();
		$('#note').hide();
	})
	$(":text").labelify({ labelledClass: "labelHighlight" });
	$("input").labelify({ labelledClass: "text_label" });

	$('#fileupload').fileupload();
	// Load existing files:
	// Open download dialogs via iframes,
	// to prevent aborting current uploads:
	$('#fileupload .files a:not([target^=_blank])').live('click', function (e) {
	e.preventDefault();
	$('<iframe style="display:none;"></iframe>')
	    .prop('src', this.href)
	    .appendTo('body');
	});
	$('#session_password_clear').show();
	$('#session_password').hide();
	 
	$('#session_password_clear').focus(function() {
	    $('#session_password_clear').hide();
	    $('#session_password').show();
	    $('#session_password').focus();
	});
	$('#session_password').blur(function() {
	    if($('#session_password').val() == '') {
	        $('#session_password_clear').show();
	        $('#session_password').hide();
	    }
	});

	$('#user_password_clear').show();
		$('#user_password').hide();
		 
	$('#user_password_clear').focus(function() {
		    $('#user_password_clear').hide();
		    $('#user_password').show();
		    $('#user_password').focus();
		});
		$('#user_password').blur(function() {
		    if($('#user_password').val() == '') {
			$('#user_password_clear').show();
			$('#user_password').hide();
		    }
		});

	$('#user_password_confirmation_clear').show();
		$('#user_password_confirmation').hide();
		 
	$('#user_password_confirmation_clear').focus(function() {
		    $('#user_password_confirmation_clear').hide();
		    $('#user_password_confirmation').show();
		    $('#user_password_confirmation').focus();
		});
		$('#user_password_confirmation').blur(function() {
		    if($('#user_password_confirmation').val() == '') {
			$('#user_password_confirmation_clear').show();
			$('#user_password_confirmation').hide();
		    }
		});

});
