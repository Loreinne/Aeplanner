Feature: Sign up, Retrieve User, update user details

  Scenario: Signup User
    Given the following information:
      | email_address | first_name | last_name | password |
      | marcabz@gmail.com | Mary| Cabz | mar123 |
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


Scenario: Update user details
    Given a user with id no. '4' exist
    When I update the user details into the following:
    |user_id| email_address | first_name | last_name | password |
    | 4 | clark@gmail.com | Dustin | Clark | miming |
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'


Scenario: User already have an account
    Given the following information:
    | email_address | first_name | last_name | password |
		| eloreinne@gmail.com | Loreinne | Estenzo | lala |
    When I submit the signup form
    Then i will get a '200' response
    And it should have a field 'message' containing 'Error'



  Scenario: Signup User with email address empty
    Given the following information:
      | email_address | first_name | last_name | password |
      |  | Mary| Cabz | mar123 |
    When I submit the signup form
    Then i will get a '200' response
    And it should have a field 'status' containing 'Error'


   Scenario: Signup User with first name
    Given the following information:
      | email_address | first_name | last_name | password |
      | marcabz@gmail.com | | Cabz | mar123 |
    When I submit the signup form
    Then i will get a '200' response
    And it should have a field 'status' containing 'Error'


 Scenario: Signup User with last name
    Given the following information:
      | email_address | first_name | last_name | password |
      | marcabz@gmail.com | Mary | | mar123 |
    When I submit the signup form
    Then i will get a '200' response
    And it should have a field 'status' containing 'Error'


 Scenario: Signup User with password
    Given the following information:
      | email_address | first_name | last_name | password |
      | marcabz@gmail.com | Mary| Cabz | |
    When I submit the signup form
    Then i will get a '200' response
    And it should have a field 'status' containing 'Error'
