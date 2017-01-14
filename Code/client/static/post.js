/**
 * Created by loreinne on 12/20/16.
 */

function addVenue() {
    var name = $('#name').val();
    var email_address = $('#email_address').val();
    var description = $('#description').val();
    var location = $('#location').val();
    var capacity = $('#capacity').val();
    var pricing = $('#pricing').val();
    var categories = $('#categories').val();



    var data = JSON.stringify({ "name": name,
                                "email_address": email_address,
                                "description": description,
                                "location" : location,
                                "capacity": capacity,
                                "pricing" : pricing,
                                "categories": categories});

    $.ajax({
        url: 'http://127.0.0.1:5000/api/v1.0/venue/',
        type: 'POST',
        contentType:"application/json; charset=utf-8",
        data: data,
        dataType: 'json',
        success: function(res){
            if(res.status=='ok') {
                alert("Venue Added")
            } else {
                alert("Error")
            }
        }

    });
}



function addCater() {
    var name = $('#name').val();
    var email_address = $('#email_address').val();
    var description = $('#description').val();
    var location = $('#location').val();
    var pricing = $('#pricing').val();
    var categories = $('#categories').val();



    var data = JSON.stringify({ "name": name,
                                "email_address": email_address,
                                "description": description,
                                "location" : location,
                                "pricing" : pricing,
                                "categories": categories});

    $.ajax({
        url: 'http://127.0.0.1:5000/api/v1.0/catering_services/',
        type: 'POST',
        contentType:"application/json; charset=utf-8",
        data: data,
        dataType: 'json',
        success: function(res){
            if(res.status=='ok') {
                alert("Catering Service Added")
            } else {
                alert("Error")
            }
        }

    });
}



function addEvent() {
    var title = $('#title').val();
    var date_event = $('#date_event').val();
    var time_event = $('#time_event').val();


    var data = JSON.stringify({ "title": title,
                                "date_event": date_event,
                                "time_event": time_event });

    $.ajax({
        url: 'http://127.0.0.1:5000/api/v1.0/events/',
        type: 'POST',
        contentType:"application/json; charset=utf-8",
        data: data,
        dataType: 'json',
        success: function(res){
            if(res.status=='ok') {
                alert("Event Added")
            } else {
                alert("Error")
            }
        }

    });
}


function addProposal() {
    var name = $('#name').val();
    var address = $('#address').val();
    var proposal_num = $('#proposal_num').val();
    var proposal_name = $('#proposal_name').val();
    var proposal_date = $('#proposal_date').val();



    var data = JSON.stringify({
        "name": name,
        "address": address,
        "proposal_num": proposal_num,
        "proposal_name": proposal_name,
        "proposal_date": proposal_date,
    });
    $.ajax({
        url: 'http://127.0.0.1:5000/api/v1.0/proposal/',
        type: 'POST',
        contentType:"application/json; charset=utf-8",
        data: data,
        dataType: 'json',
        success: function(res){
            if(res.status=='ok') {
                alert("Proposal Added")
            } else {
                alert("Error")
            }
        }

    });
}
