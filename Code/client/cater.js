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

					clearVenueForm();

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

