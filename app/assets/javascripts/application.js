// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(document).foundation();
var login_url = "";
var mail_freq = "";
var email = "";
$(document).ready(function() {
  login_url = $("#twitter_login").attr("href");
  $("#twitter_login").attr("href", "#email");
  $("#twitter_login").click(function() {
  	email = $("#email").val();
  	if(IsEmail(email)) {
  		mail_freq = $('input:radio[name=mail_frequency]:checked').val();
  		window.location.href = login_url +"?mail_frequency=" + mail_freq + "&email=" + email ;
  	}
  	else {
  		if($("#email").val().length == 0)
  		  $("#email_error").html("Please enter your email address");
  		else
  		  $("#email_error").html("Please enter a valid email");
  		$("#email_error").show();
  		$("#email").addClass("error");
  	}
  	
  });
});

function IsEmail(email) {
  var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  return regex.test(email);
}