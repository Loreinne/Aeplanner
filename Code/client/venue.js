/**
 * Created by loreinne on 12/18/16.
 */
var auth_user = "";
var user_role;
var timer = 0;

$(document).ready(function(){


});

function clearVenueForm(){
	var venue_form = document.getElementById("venue-form");
	venue_form.reset();
}

function storeVenue(){
	var name = $('#name').val();
	var email_address = $('#email_address').val();
	var description = $('#description').val();
	var location = $('#location').val();
	var capacity = $('#capacity').val();
	var pricing = $('#pricing').val();
	var location = $('#location').val();
	var categories = $('#categories').val();

	var data = JSON.stringify({ 'name' : name,
                                'email_address' email_address,
								'description' : description,
								'location' : location,
                                'capacity' : capacity,
                                'pricing' : pricing,
                                'location' : location,
                                'categories' : categories
	});

	$.ajax({
	    	type:"POST",
	    	url: "http://127.0.0.1:5000/api/v1.0/venue/",
	    	contentType:"application/json; charset=utf-8",
			data:data,
			dataType:"json",

			success: function(results){
				if (results.status == 'OK'){

					$('#add-venue-alert').html(
						'<div class="alert alert-success"><strong>Success ' +
						 '!</strong>' + results.message +'</div>');

					$("#add-venue-alert").fadeTo(2000, 500).slideUp(500);

					$("#add-venue-form").hide();

					clearVenueForm();

				}

				if(results.status == 'FAILED'){

					$('#add-venue-alert').html(
						'<div class="alert alert-danger"><strong>Failed ' +
						 '!</strong>' + results.message +'</div>');

					$("#add-venue-alert").fadeTo(2000, 500).slideUp(500);

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



function viewvenueById(id){
	$.ajax({
		type:"GET",
		url: "http://127.0.0.1:5000/api/v1.0/venue/" + id,
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results)
		{;
			if(results.status == 'OK'){
				$('#view-resto-info').html(function(){
					var venue_row = '';
					var venue
					for (var i = 0; i < results.entries.length; i++) {
						venue = '<div class="box-body">' +
										'<div class="container">' +
			                                '<div class="row">' +
			                                	'<h4 class="box-title"><b>'+ 'Venue\'s Name: ' + results. entries[i].name +'</b></h3></div>' +
			                                    '<div class="col-md-4">' +
			                                        '<p style="margin-left: 5px">' +
                                                         'Name: ' + results.entries[i].name + '<br><br>' +
														 'Email Address: ' + results.entries[i].email_address + '<br><br>' +
														 'Description: ' + results.entries[i].description + '<br><br>' +
                                                         'Location.: ' + results.entries[i].location + '<br><br>' +
                                                         'Capacity.: ' + results.entries[i].capacity + '<br><br>' +
                                                         'Pricing: ' + results.entries[i].pricing + '<br><br>' +
                                                         'Categories: ' + results.entries[i].capacity + '<br><br>' +
			                                        '</p>' +
			                                    '</div>'
			                                '</div>' +
			                            '</div>' +
			                        '</div>'

						venue_row  += venue
					}

					return venue_row;
				})

				$('#add-venue-form').hide();
			}

			if(results.status == 'FAILED'){

				$('#view-venue-alert').html(
						'<div class="alert alert-danger"><strong>FAILED ' +

						 '!</strong>'+ results.message +' </div>');
				$("#view-venue-alert").fadeTo(2000, 500).slideUp(500);

			}
		},

		beforeSend: function (xhrObj){

			xhrObj.setRequestHeader("Authorization", "Basic " + btoa( auth_user ));

		}

	});
}