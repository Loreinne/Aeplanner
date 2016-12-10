Feature: Add, View, Update Venue


	Scenario: Add new venue
    	Given the following information:
      	| name | description | cat_id | location | capacity | pricing |
      	| Clarkson | Nice,hahha | 1 | Paris | 200 | 100,000 |
    	When I click the add button
    	Then i will get a '200' response
    	And it should have a field 'status' containing 'OK'


    Scenario: Get existing venue
        Given that a venue with id no. '4' exist
        When I retrieve a venue with id no. '4'
        Then i will get a '200' response
        And the following details are returned:
        |id| name | description | cat_id | location | capacity | pricing |
        |4| leila |nice| 1 | iligan | 200 | 800000 |


    Scenario: Update venue details
        Given a venue with id no. '5' exist
        When I update the venue details into the following:
        |id| name | description | cat_id | location | capacity | pricing |
        |5| Britania |nice| 1 | iligan | 200 | 800000 |
        Then I will get a '200' response
        And it should have a field 'status' containing 'OK'


    Scenario: Add new venue with name field empty
        Given the following information:
        | name | description | cat_id | location | capacity | pricing |
        |  | Nice,hahha | 1 | Paris | 200 | 100,000 |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new venue with description field empty
        Given the following information:
        | name | description | cat_id | location | capacity | pricing |
        | Clarkson | | 1 | Paris | 200 | 100,000 |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new venue with location field empty
        Given the following information:
        | name | description | cat_id | location | capacity | pricing |
        | Clarkson | Nice,hahha | 1 |  | 200 | 100,000 |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new venue with capacity field empty
        Given the following information:
        | name | description | cat_id | location | capacity | pricing |
        | Clarkson | Nice,hahha | 1 | Paris | | 100,000 |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new venue with pricong field empty
        Given the following information:
        | name | description | cat_id | location | capacity | pricing |
        | Clarkson | Nice,hahha | 1 | Paris | 200 | 100,000 |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'

