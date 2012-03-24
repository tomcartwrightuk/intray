// // Place your application-specific JavaScript functions and classes here
// // This file is automatically included by javascript_include_tag :defaults
// 

$(function() {
	$('#add_note').hide();
	$('#noteheading').hide();
	$('#addnotebutton').click(function() {
		$('#add_note').show(300);
		$('#noteheading').show(200);
		$('#addnotebutton').hide();
		$('#note').hide();
	})
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
	$('#user_confirmation_password').hide();
	 
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

