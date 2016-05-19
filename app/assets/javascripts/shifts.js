// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
function displayShiftInfo (shiftDate){
	$.ajax({
		type: 'GET',
		url: '/shifts/' +  shiftDate,
		dataType: 'json',
		success: handleShiftInfoResponse		
	})
}

function handleShiftInfoResponse (response){
	console.log(response);
	if(response==undefined){
		$('.js-display-day-info').html('Information no available')
	}
	else{
		//$('.js-display-day-info').html(response[0].id);
	var coworkersDay = response.filter(function(obj){
		return obj.shift_slot_id == 2;
	});
	console.log(coworkersDay);
	console.log('holaquease')
		console.log($('.js-shift-date').val().html)
		$('.js-display-day-info').append(

			"<a class='waves-effect waves-light btn'><i class='material-icons right'>swap_horiz</i>Change Shift</a>");

		//<%= link_to "Change Shift", user_request_path(id: @shift.id), :class => "btn btn-default btn-lg" %>


	};
		
}



$(document).on('ready',function(){
	$(this).find('.day').on('click', function(event) {
  		event.preventDefault();
  		var shiftDate = $(this).find('p.js-shift-date').text();
	    console.log(shiftDate);
	    displayShiftInfo(shiftDate);

	   $('.js-display-day').html(shiftDate);



	});
});

