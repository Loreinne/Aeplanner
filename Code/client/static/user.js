/**
 * Created by loreinne on 12/20/16.
 */
var auth_user = "";
var user_role;
var timer = 0;

$(document).ready(function(){


});


function signup() {
    var email_address = $('#email_address').val();
    var fname = $('#fname').val();
    var lname = $('#lname').val();
    var password = $('#password').val();
    var address = $('#address').val();
    var birthdate = $('#birthdate').val();
    var age = $('#age').val();


    var data = JSON.stringify({
        'email_address': email_address,
        'fname': fname,
        'lname': lname,
        'password': password,
        'address': address,
        'birthdate': birthdate,
        'age': age

    });
    $.ajax({
        type: "POST",
        url: "http://localhost:5000/api/v1.0/signup/",
        contentType: "application/json; charset=utf-8",
        data: data,
        dataType: "json",

        success: function (results) {
            if (results.status == 'OK') {

                $('#add-user-form').show();

                $('#welcome-alert-admin').html(
                    '<div class="alert alert-success"><strong>Successfully added ' +
                    fname + lname +
                    '!</strong> with role id: ' + role_id + '</div>');
                $("#welcome-alert-admin").fadeTo(2000, 500).slideUp(500);

                var form = document.getElementById("register");
                form.reset();

            }

            if (results.status == 'FAILED') {
                $('#add-user-form').show();

                $('#welcome-alert-admin').html(
                    '<div class="alert alert-danger"><strong>Failed to add ' +
                    fname + lname +
                    '!</strong>' + results.message + '</div>');
                $("#welcome-alert-admin").fadeTo(2000, 500).slideUp(500);
            }

        },

        error: function (e, stats, err) {
            console.log(err);
            console.log(stats);
        },

        beforeSend: function (xhrObj) {

            xhrObj.setRequestHeader("Authorization", "Basic " + btoa(auth_user));

        }

    });

else
    {
        alert("UNAUTHORIZE ACCESS");
    }

}
