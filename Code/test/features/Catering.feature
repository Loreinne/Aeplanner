Feature: Add, View, Update Catering service


    Scenario: Add new catering service
        Given the following information:
        | name | email_address | description | location | pricing | cat_id |
        | Moana's Catering Services | moana@gmail.com | Nice,hahha | Cagayan De Oro City |100 per person | 1 |
        When I click the add catering services
        Then i will get a '200' response
        And it should have a field 'status' containing 'OK'


    Scenario: Get existing catering service
        Given that a catering service with id no. '2' exist
        When I retrieve a catering service with id no. '2'
        Then i will get a '200' response
        And the following details are returned:
        |id| name | email_address | description | location | pricing | cat_id |
        |2| Clark's Catering Services | clark@gmail.com | nice | Cebu | 200 per person | 1 |


    Scenario: Update catering service details
        Given that a catering service with id no. '3' exist
        When I update the catering service details into the following:
        |id| name | email_address | description | location | pricing | cat_id |
        |3| Britania's Catering Services | brita@gmail.com | nice | Surigao | 100 per person | 1 |
        Then I will get a '200' response
        And it should have a field 'status' containing 'OK'

    Scenario: Add catering service that already exist
        Given the following information:
        |id| name | email_address | description | location | pricing | cat_id |
        |2| Clark's Catering Services | clark@gmail.com | nice | Cebu | 200 per person | 1 |
        When I click the add catering services
        Then i will get a '200' response
        And it should have a field 'message' containing 'Error'


    Scenario: Add new catering service with name field empty
        Given the following information:
        | name | email_address | description | location | pricing | cat_id |
        | | clark@gmail.com | nice | Cebu | 200 per person | 1 |
        When I click the add catering services
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new catering service with description field empty
        Given the following information: 
        | name | email_address | description | location | pricing | cat_id |
        | Clark's Catering Services | clark@gmail.com | | Cebu | 200 per person | 1 |
        When I click the add catering services
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new catering service with location field empty
        Given the following information:
        | name | email_address | description | location | pricing | cat_id |
        | Clark's Catering Services | clark@gmail.com | nice | | 200 per person | 1 |
        When I click the add catering services
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new catering service with pricing field empty
        Given the following information:
        | name | email_address | description | location | pricing | cat_id |
        | Clark's Catering Services | clark@gmail.com | nice | Cebu | | 1 |
        When I click the add catering services
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'


 Scenario: Add new catering service with email_address field empty
        Given the following information:
        | name | email_address | description | location | pricing | cat_id |
        | Clark's Catering Services | | nice | Cebu | 200 per person| 1 |
        When I click the add catering services
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'
