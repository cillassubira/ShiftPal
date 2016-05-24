// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('ready',function(){

	$('.send-request-btn').on('click', function(event){
		event.preventDefault();
		$(this).addClass('disabled');
		$(this).text('Request Sent!');
	});

	$(function() {
  		setTimeout(function(){
    		$('.alert').slideUp(500);
    	}, 3000);
	});
});

