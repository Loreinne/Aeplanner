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


function vieweventById(id){
	$.ajax({
		type:"GET",
		url: "http://127.0.0.1:5000/api/v1.0/events/" + id,
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results)
		{;
			if(results.status == 'OK'){
				$('#view-cater-info').html(function(){
					var event_row = '';
					var event
					for (var i = 0; i < results.entries.length; i++) {
						event = '<div class="box-body">' +
										'<div class="container">' +
			                                '<div class="row">' +
			                                	'<h4 class="box-title"><b>'+ 'Event Title: ' + results. entries[i].name +'</b></h3></div>' +
			                                    '<div class="col-md-4">' +
			                                        '<p style="margin-left: 5px">' +
														 'Date: ' + results.entries[i].date_event + '<br><br>' +
														 'Time: ' + results.entries[i].time_event + '<br><br>' +
			                                        '</p>' +
			                                    '</div>'
			                                '</div>' +
			                            '</div>' +
			                        '</div>'

						event_row  += event
					}

					return event_row;
				})

				$('#add-event-form').hide();
			}

			if(results.status == 'FAILED'){

				$('#view-event-alert').html(
						'<div class="alert alert-danger"><strong>FAILED ' +

						 '!</strong>'+ results.message +' </div>');
				$("#view-event-alert").fadeTo(2000, 500).slideUp(500);

			}
		},

		beforeSend: function (xhrObj){

			xhrObj.setRequestHeader("Authorization", "Basic " + btoa( auth_user ));

		}

	});
}


function viewAllcater(){

	$.ajax({
		type:"GET",
		url: "http://127.0.0.1:5000/api/v1.0/events/",
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results)
		{
			if(results.status == 'OK'){
				$('#view-event-table-body').html(function(){
					var event_row = '';
					var event;

					for (var i = 0; i < results.entries.length; i++) {
						event = '<tr>' +
										'<td>' + results.entries[i].title + '</td>' +
										'<td>' + results.entries[i].date_event + '</td>' +
										'<td>' + results.entries[i].time_event + '</td>' +
                                        '<td>'+'<button onclick="vieweventById('+ results.entries[i].id +'); $(\'#view-event\').show();$(\'#view-all-event\').hide()" class="btn btn-info">View</button>'+'</td>'+
										'<td>'+'<button onclick="updateEvent('+ results.entries[i].id +'); $(\'#update-event-form\').show();$(\'#view-all-event\').hide()" class="btn btn-info">Update</button>'+'</td>'+
									 '</tr>';

						event_row  += event
					}

					return event_row;
				})

				$('#add-event-form').hide();
			}

			if(results.status == 'FAILED'){

				$('#message-alert').html(
						'<div class="alert alert-danger"><strong>FAILED ' +

						 '!</strong>'+ results.message +' </div>');
				$("#message-alert").fadeTo(2000, 500).slideUp(500);

			}
		},

		beforeSend: function (xhrObj){

			xhrObj.setRequestHeader("Authorization", "Basic " + btoa( auth_user ));

		}

	});
}