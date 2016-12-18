/**
 * Created by loreinne on 12/18/16.
 */
var auth_user = "";
var user_role;
var timer = 0;

$(document).ready(function(){


});

function clearCaterForm(){
	var cater_form = document.getElementById("cater-form");
	cater_form.reset();
}

function storeCater(){
	var name = $('#name').val();
	var email_address = $('#email_address').val();
	var description = $('#description').val();
	var location = $('#location').val();
	var pricing = $('#pricing').val();
	var location = $('#location').val();
	var categories = $('#categories').val();

	var data = JSON.stringify({ 'name' : name,
                                'email_address': email_address,
								'description' : description,
								'location' : location,
                                'pricing' : pricing,
                                'location' : location,
                                'categories' : categories
	});

	$.ajax({
	    	type:"POST",
	    	url: "http://127.0.0.1:5000/api/v1.0/catering_services/",
	    	contentType:"application/json; charset=utf-8",
			data:data,
			dataType:"json",

			success: function(results){
				if (results.status == 'OK'){

					$('#add-cater-alert').html(
						'<div class="alert alert-success"><strong>Success ' +
						 '!</strong>' + results.message +'</div>');

					$("#add-cater-alert").fadeTo(2000, 500).slideUp(500);

					$("#add-cater-form").hide();

					clearCaterForm();

				}

				if(results.status == 'FAILED'){

					$('#add-cater-alert').html(
						'<div class="alert alert-danger"><strong>Failed ' +
						 '!</strong>' + results.message +'</div>');

					$("#add-cater-alert").fadeTo(2000, 500).slideUp(500);

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

function viewcaterById(id){
	$.ajax({
		type:"GET",
		url: "http://127.0.0.1:5000/api/v1.0/catering_services/" + id,
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results)
		{;
			if(results.status == 'OK'){
				$('#view-cater-info').html(function(){
					var cater_row = '';
					var cater
					for (var i = 0; i < results.entries.length; i++) {
						cater = '<div class="box-body">' +
										'<div class="container">' +
			                                '<div class="row">' +
			                                	'<h4 class="box-title"><b>'+ 'Catering Service\'s Name: ' + results. entries[i].name +'</b></h3></div>' +
			                                    '<div class="col-md-4">' +
			                                        '<p style="margin-left: 5px">' +
														 'Email Address: ' + results.entries[i].email_address + '<br><br>' +
														 'Description: ' + results.entries[i].description + '<br><br>' +
                                                         'Location.: ' + results.entries[i].location + '<br><br>' +
                                                         'Pricing: ' + results.entries[i].pricing + '<br><br>' +
                                                         'Categories: ' + results.entries[i].capacity + '<br><br>' +
			                                        '</p>' +
			                                    '</div>'
			                                '</div>' +
			                            '</div>' +
			                        '</div>'

						cater_row  += cater
					}

					return cater_row;
				})

				$('#add-cater-form').hide();
			}

			if(results.status == 'FAILED'){

				$('#view-cater-alert').html(
						'<div class="alert alert-danger"><strong>FAILED ' +

						 '!</strong>'+ results.message +' </div>');
				$("#view-cater-alert").fadeTo(2000, 500).slideUp(500);

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
		url: "http://127.0.0.1:5000/api/v1.0/catering_services/",
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results)
		{
			if(results.status == 'OK'){
				$('#view-cater-table-body').html(function(){
					var cater_row = '';
					var cater;

					for (var i = 0; i < results.entries.length; i++) {
						cater = '<tr>' +
										'<td>' + results.entries[i].name + '</td>' +
										'<td>' + results.entries[i].email_address + '</td>' +
										'<td>' + results.entries[i].description + '</td>' +
										'<td>' + results.entries[i].location + '</td>' +
										'<td>' + results.entries[i].pricing + '</td>' +
										'<td>' + results.entries[i].categories + '</td>' +
                                        '<td>'+'<button onclick="viewcaterById('+ results.entries[i].id +'); $(\'#view-cater\').show();$(\'#view-all-cater\').hide()" class="btn btn-info">View</button>'+'</td>'+
										'<td>'+'<button onclick="updateCater('+ results.entries[i].id +'); $(\'#update-cater-form\').show();$(\'#view-all-cater\').hide()" class="btn btn-info">Update</button>'+'</td>'+
									 '</tr>';

						cater_row  += cater
					}

					return cater_row;
				})

				$('#add-cater-form').hide();
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