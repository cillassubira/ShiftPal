// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
userID = window.location.pathname.split("/")[2]

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
	console.log(response);
	console.log(response.slot);
	// if(response==undefined){
	// 	$('.js-display-day-info').html('Information not available')
	// }
	// else{
	// 	//$('.js-display-day-info').html(response[0].id);
	// var coworkersDay = response.filter(function(obj){
	// 	return obj.shift_slot_id == 2;
	// });
	// console.log(coworkersDay);
	// console.log('holaquease')
		
//}
}



$(document).on('ready',function(){
	$(this).find('.day').on('click', function(event) {
  		event.preventDefault();
  		var shiftDate = $(this).find('p.js-shift-date').text();
  		$('.js-display-day').html(shiftDate);
  		var shiftId = $(this).find('p.js-shift-id').text();
  		var shiftSlot = $(this).find('p.js-shift-slot').text();
	    console.log(shiftDate);
	    console.log(shiftId);
	    console.log(shiftSlot);
	    var shiftRequestUrl = "/users/" + userID + "/shifts/" + shiftId;
	    console.log(shiftRequestUrl);
	    var requestsUrl = "/users/" + userID + "/requests/" + parseInt(shiftId);
	    console.log("URL REQUESTS");
	    console.log(requestsUrl)
	    //Ocultar botón para que no salga
	 //    $('.js-display-day-info').append(
		// "<a class='waves-effect waves-light btn'><i class='material-icons right'>swap_horiz</i>Change Shift</a>");
		$('.js-display-day-info').append(
			"<a href=" + requestsUrl + 
			" class='waves-effect waves-light btn'><i class='material-icons right'>swap_horiz</i>Change Shift</a>");
		displayShiftInfo(shiftRequestUrl);
	   



	});
});

