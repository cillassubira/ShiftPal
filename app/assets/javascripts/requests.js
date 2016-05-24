// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('ready',function(){   
	$('.seen-request-btn').on('click', function(event){
		$(this).addClass('disabled');
		$(this).delete();
	});
    $('.accept-request-btn').on('click', function(event){
       $('.modal-request-answer').html("You accepted <%= User.find(@request.user_requesting_id).alias %> request to change:");
       $('#modal-request-answer').openModal();

    });
    $('.reject-request-btn').on('click', function(event){
        $('.modal-request-answer').html("You rejected <%= User.find(@request.user_requesting_id).alias %> request to change:");
        $('#modal-request-answer').openModal();

    });
});

    



