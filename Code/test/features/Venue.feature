Feature: Add, View, Update Venue


    Scenario: Add new venue
        Given the following information:
        | name | email_address | description | location | capacity | pricing | cat_id |
        | Clarkson | clarkson@gmail.com | Nice,hahha | Paris | 200 | 100,000 | 1 |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'OK'


    Scenario: Get existing venue
        Given that a venue with id no. '4' exist
        When I retrieve a venue with id no. '4'
        Then i will get a '200' response
        And the following details are returned:
        |id| name | email_address | description | location | capacity | pricing | cat_id |
        |4| leila | leila@gmail.com | nice | iligan | 200 | 800000 | 1 |


    Scenario: Update venue details
        Given that a venue with id no. '5' exist
        When I update the venue details into the following:
        |id| name | email_address | description | location | capacity | pricing | cat_id |
        |5| Britania |brit@gmail.com | nice | iligan | 200 | 800000 | 1 |
        Then I will get a '200' response
        And it should have a field 'status' containing 'OK'


    Scenario: Add new venue with name field empty
        Given the following information:
        | name | email_address | description | location | capacity | pricing | cat_id |
        |  | hello@gmail.com | Nice,hahha | Paris | 200 | 100,000 | 1 |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new venue with description field empty
        Given the following information:
        | name | email_address | description | location | capacity | pricing | cat_id |
        | Clarkson | clarkson@gmail.com | | Paris | 200 | 100,000 | 1 |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new venue with location field empty
        Given the following information:
       | name | email_address | description | location | capacity | pricing | cat_id |
        | Clarkson | clarkson@gmail.com | Nice, hahaha | | 200 | 100,000 | 1 |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new venue with capacity field empty
        Given the following information:
        | name | email_address | description | location | capacity | pricing | cat_id |
        | Clarkson | clarkson@gmail.com |Nice, hahaha | Paris | | 100,000 | 1 |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new venue with pricing field empty
        Given the following information:
        | name | email_address | description | location | capacity | pricing | cat_id |
        | Clarkson | clarkson@gmail.com | Nice, hahaha | Paris | 200 | | 1 |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'

