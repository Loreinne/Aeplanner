/**
 * Created by loreinne on 12/20/16.
 */
function getvenue(name, email_address, description, location, capacity, pricing, categories) {
    return '<tr>' +
                    '<td>' + name + '</td>' +
                    '<td>' + email_address + '</td>' +
                    '<td>' + description + '</td>' +
                    '<td>' + location + '</td>' +
                    '<td>' + capacity + '</td>' +
                    '<td>' + pricing + '</td>' +
                    '<td>' + categories + '</td>' +
                '</tr>'
}




function getVenues() {
    $.ajax({
        url: 'http://127.0.0.1:5000/api/v1.0/venue/',
        type: 'GET',
        dataType: 'json',
        success: function(res) {
            $("#venue").html("");
            if(res.status=='ok'){
                for (i=0; i<res.count; i++) {
                    name = res.entries[i].name;
                    email_address = res.entries[i].email_address;
                    description = res.entries[i].description;
                    location = res.entries[i].location;
                    capacity = res.entries[i].capacity;
                    pricing= res.entries[i].pricing;
                    categories = res.entries[i].categories;


                    $("#venue").append(getvenue(name, email_address, description, location, capacity, pricing, categories));
                }
            } else {
                $("#venue").html("");
                alert('Error')
            }
        }


    });

}



function getcater(name, email_address, description, location, pricing, categories) {
    return '<tr>' +
                    '<td>' + name + '</td>' +
                    '<td>' + email_address + '</td>' +
                    '<td>' + description + '</td>' +
                    '<td>' + location + '</td>' +
                    '<td>' + pricing + '</td>' +
                    '<td>' + categories + '</td>' +
                '</tr>'
}




function getCaters() {
    $.ajax({
        url: 'http://127.0.0.1:5000/api/v1.0/catering_services/',
        type: 'GET',
        dataType: 'json',
        success: function(res) {
            $("#cater").html("");
            if(res.status=='ok'){
                for (i=0; i<res.count; i++) {
                    name = res.entries[i].name;
                    email_address = res.entries[i].email_address;
                    description = res.entries[i].description;
                    location = res.entries[i].location;
                    pricing= res.entries[i].pricing;
                    categories = res.entries[i].categories;


                    $("#cater").append(getcater(name, email_address, description, location, pricing, categories));
                }
            } else {
                $("#cater").html("");
                alert('Error')
            }
        }


    });

}



function getevent(title, date_event, time_event) {
    return '<tr>' +
                    '<td>' + title + '</td>' +
                    '<td>' + date_event + '</td>' +
                    '<td>' + time_event + '</td>' +
                '</tr>'
}




function getEvents() {
    $.ajax({
        url: 'http://127.0.0.1:5000/api/v1.0/events/',
        type: 'GET',
        dataType: 'json',
        success: function(res) {
            $("#event").html("");
            if(res.status=='ok'){
                for (i=0; i<res.count; i++) {
                    title = res.entries[i].title;
                    date_event = res.entries[i].date_event;
                    time_event = res.entries[i].time_event;


                    $("#event").append(getevent(title, date_event, time_event));
                }
            } else {
                $("#event").html("");
                alert('Error')
            }
        }


    });

}