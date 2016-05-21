// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

function displayShiftInfo (requesting_url){
	$.ajax({
		type: 'GET',
		url: requesting_url,
		dataType: 'json',
		success: handleShiftInfoResponse,
		error: function(response){
			console.log("Not Found")
		}		
	})
}

function handleShiftInfoResponse (response){
	$('.js-display-day-info').empty();
	if(response==undefined){
		$('.js-display-day-info').html('Information not available')
	}
	else{
		if(response.slot != "Free"){
			var requestsUrl = "/users/" + response.user_id + "/shifts/" + response.id;
			var changeShiftButton = $("<a href=" + requestsUrl + 
 				" class='waves-effect waves-light btn change-shift-btn'><i class='material-icons right'>swap_horiz</i>Change Shift</a>");
			$('.js-display-day-info').append(changeShiftButton).hide().fadeIn();
		}
	}
}


$(document).on('ready',function(){
	$(this).find('.day').on('click', function(event) {
  		event.preventDefault();
  		$('.change-shift-btn').remove();
  		var shiftId = $(this).find('p.js-shift-id').text();
	    var shiftRequestUrl = "/shift_info/" + parseInt(shiftId);
		displayShiftInfo(shiftRequestUrl);
	 });
});

