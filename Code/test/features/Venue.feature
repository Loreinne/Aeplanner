Feature: Add, View, Update Venue


	Scenario: Add new venue
    	Given the following information:
      	| V_name | V_description | V_categories | V_location | V_capacity | V_pricing |
      	| Clarkson | Nice,hahha | Good for Weddings | Paris | 200 | 100,000 |
    	When I click the add button
    	Then i will get a '200' response
    	And it should have a field 'status' containing 'OK'

Scenario: Get existing venue
    Given that a venue with id no. '4' exist
    When I retrieve a venue with id no. '4'
    Then i will get a '200' response
    And the following details are returned:
    |V_id| V_name | V_description | V_categories | V_location | V_capacity | V_pricing |
    |4| leila |nice| weddings | iligan | 200 | 800000 |