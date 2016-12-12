var auth_user = "";
var user_role;
var timer = 0;

$(document).ready(function(){



});


function login(){
	var email = $('#email_address').val();
	var password = $('#password').val();

	var data = JSON.stringify({'email_address':email_address, 'password':password});

	$.ajax({

		type:"POST",
		url:"http://localhost:8000/api/v1.0/login/",
		contentType:"application/json; charset=utf-8",
		data:data,
		dataType: "json",

		success: function(results){
			console.log(results);
			if(results.status == 'OK'){
				$('#log-in-alert').html(
						'<div class="alert alert-success"><strong>Welcome ' +
						results.data[0].fname +
						 '!</strong> Successfully logged in.</div>');

					$("#log-in-alert").fadeTo(2000, 500).slideUp(500);

					$("#login-form").hide();
				}

			if(results.status == 'FAILED'){
				$('#log-in-alert').html(
					'<div class="alert alert-danger"><strong>FAILED ' +
					 '!</strong> Invalid username or password.</div>');
			}


		},
		error: function(e){
				alert("THIS IS NOT COOL. SOMETHING WENT WRONG: " + e);
		}

	});
}



function registerUser(){
    var email = $('#email_address').val();
	var fname = $('#fname').val();
	var lname = $('#lname').val();
	var password = $('#password').val();
	var address = $('#address').val();
	var birthdate = $('#birthdate').val();
	var age = $('#age').va();
	
	

	var data = JSON.stringify({'email_address':email_address, 'fname':fname, 'lname':lname, 'password':password, 'address':address, 'birthdate':birthdate, 'age':age});


	$.ajax({

			type:'POST',
			url:'http://localhost:8000/api/v1.0/signup/',
			contentType:"application/json; charset=utf-8",
			data: data,
			dataType:'json',

			success: function(results){

				if(results.status == 'OK'){

					$('#add-user-alert').html(
							'<div class="alert alert-success"><strong>Successfully created ' +
							fname + lname +'</div>');
					$("#add-user-alert").fadeTo(2000, 500).slideUp(500);

					$("#add-user-form");
					$('#confirmMessage').hide();

                   
				}

				if(results.status == 'Error'){
					$('#add-user-alert').html(
							'<div class="alert alert-danger"><strong>Failed to create ' +
							fname + lname +
							 '!</strong>'+ results.message +'</div>');
					$("#add-user-alert").fadeTo(2000, 500).slideUp(500);
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

}



function checkPass(){
	var password = document.getElementById('password');
	var pass2 = document.getElementById('pass2');
	var message = document.getElementById('confirmMessage');
	var goodColor = "#b6ffc7";
	var goodColor_font = "#66cc66"
	var badColor = "#ffdada";
	var badColor_font = "#ff3f3f";
	if(password.value == pass2.value){
	  pass2.style.backgroundColor = goodColor;
	  message.style.color = goodColor_font;
	  message.innerHTML = "Passwords Match!"
	  document.getElementById("submit_button").disabled = false;
	}
	else{
	  pass2.style.backgroundColor = badColor;
	  message.style.color = badColor_font;
	  message.innerHTML = "Passwords Do Not Match!"
	  document.getElementById("submit_button").disabled = true;
	}
}
