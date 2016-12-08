Feature: Add, Retrieve, update catering services details


	Scenario: Add new catering
    	Given the following information:
      	| name | description | cat_id | location | capacity | pricing |
      	| laylay | Nice,hahha | 1 | iligan | 100 | 100,000 |
    	When I click the add button
    	Then i will get a '200' response
    	And it should have a field 'status' containing 'OK'


	Scenario: Get existing venue
        Given that a catering services with id no. '3' exist
        When I retrieve a venue with id no. '3'
        Then i will get a '200' response
        And the following details are returned:
        |id| name | description | cat_id | location | capacity | pricing |
        |3| Villamore | great| 1 | Hongkong | 300 | 900000 |


      Scenario: Update venue details
        Given a venue with id no. '4' exist
        When I update the venue details into the following:
        |id| name | description | cat_id | location | capacity | pricing |
        |4| Orion |nice| 1 | Cagayan | 200 | 800000 |
        Then I will get a '200' response
        And it should have a field 'status' containing 'OK'


	Scenario: Venue already exist
    	Given the following information:
    	|id| name | description | cat_id | location | capacity | pricing |
        |3| Villamore | great| 1 | Hongkong | 300 | 900000 |
    	When I submit the signup form
   	 	Then i will get a '200' response
    	And it should have a field 'message' containing 'Error'
