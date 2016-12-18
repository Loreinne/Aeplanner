/**
 * Created by loreinne on 12/18/16.
 */
var auth_user = "";
var user_role;
var timer = 0;

$(document).ready(function(){


});

function clearEventForm(){
	var event_form = document.getElementById("event-form");
	event_form.reset();
}

function storeEvent(){
	var title = $('#title').val();
	var date_event = $('#date_event').val();
	var time_event = $('#time_event').val();

	var data = JSON.stringify({ 'time' : time,
                                'date_event': date_event,
								'time_event' : time_event
	});

	$.ajax({
	    	type:"POST",
	    	url: "http://127.0.0.1:5000/api/v1.0/events/",
	    	contentType:"application/json; charset=utf-8",
			data:data,
			dataType:"json",

			success: function(results){
				if (results.status == 'OK'){

					$('#add-event-alert').html(
						'<div class="alert alert-success"><strong>Success ' +
						 '!</strong>' + results.message +'</div>');

					$("#add-event-alert").fadeTo(2000, 500).slideUp(500);

					$("#add-event-form").hide();

					clearEventForm();

				}

				if(results.status == 'FAILED'){

					$('#add-event-alert').html(
						'<div class="alert alert-danger"><strong>Failed ' +
						 '!</strong>' + results.message +'</div>');

					$("#add-event-alert").fadeTo(2000, 500).slideUp(500);

				}
			},
			error: function(e){
				alert("THIS IS NOT COOL. SOMETHING WENT WRONG: " + e);
			},
			beforeSend: function (xhrObj){

	      		xhrObj.setRequestHeader("Authorization", "Basic " + btoa( auth_user ));

	        }
	    });
}