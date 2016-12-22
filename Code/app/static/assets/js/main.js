var auth_user = "";
var user_role;
var timer = 0;


$(document).ready(function(){

	
});

function storeProposal(){
	var name = $('#event-input-name').val();
	var address = $('event-input-address').val();
	var proposal_num = $('event-input-proposal_num').val();
	var proposal_name = $('event-input-proposal_name').val();
	var proposal_date = $('event-input-proposal_date').val();

	var data =JSON.stringify({'name': name,
							  'address': address,
							  'proposal_num': proposal_num,
							  'proposal_name': proposal_name,
							  'proposal_date': proposal_date });

	$.ajax({
		type: "POST",
		url: "http://localhost:8051/api/v1.0/proposal/",
		contentType: "application/json; charset=utf-8",
		data: data,
		dataType: "json",

		success: function(results){
			if(results.status.status == 'OK'){
				$('#welcome-alert-user').html('<div class="alert alert-success"><strong>Successful' + '!</strong>' + results.message + '</div>');
				$('#welcome-alert-user').fadeTo(2000, 500).slideUp(500);
			}

			if(results.status == 'FAILED'){
				$('#welcome-alert-user').html('div class="alert-danger"><strong>FAILED'+ '!</strong>' + results.message + '</div>');
				$('#welcome-alert-user').fadeTo(2000, 500).slideUp(500);
			}
		},

		error: function(e, stats, err){
			console.log(err);
			console.log(stats);
			alert('This is not cool. Something went wrong');
		},

		beforeSend: function(xhrObj){
			xhrObj.setRequestHeader("Authorization", "Basic" + btoa(auth_user));
		}
	});
}