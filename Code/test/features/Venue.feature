Feature: Add, View, Update Venue


	Scenario: Add new venue
    	Given the following information:
      	| V_name | V_description | V_categories | V_location | V_capacity | V_pricing |
      	| Clarkson | Nice,hahha | Good for Weddings | Paris | 200 | 100,000 |
    	When I click the add button
    	Then i will get a '200' response
    	And it should have a field 'status' containing 'OK'


    Scenario: Update venue
    	Given a user with id no. '2' exist
    	When I update the venue details into the following:
    	| V_id | V_name | V_description | V_categories | V_location | V_capacity | V_pricing |
      	| 2 | hello | bablah |Good for Weddings | Paris | 200 | 100,000 |
    	Then I will get a '200' response
    	And it should have a field 'status' containing 'OK'
