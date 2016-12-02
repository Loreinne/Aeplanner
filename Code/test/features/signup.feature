Feature: Sign up, Retrieve User

  Scenario: Signup User
    Given the following information:
      | email_address | first_name | last_name | password |
      | m@gmail.com | Marjorie | Buctolan | marj123 |
    When I submit the signup form
    Then i will get a '200' response
    And it should have a field 'status' containing 'OK'



Scenario: Retrieve user details
	
	Given a user with id '1'
	When i retrieve a user with id '1'
	Then i will get a '200' response 
	And the following details are returned:
		| email_address | first_name | last_name |
		| eloreinne@gmail.com | Loreinne | Estenzo |