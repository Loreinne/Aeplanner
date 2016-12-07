Feature: Sign up, Retrieve User, update user details

  Scenario: Signup User
    Given the following information:
      | email_address | fname | lname | password | birthdate | age |
      | marcabz@gmail.com | Mary| Cabz | mar123 | June 25,1996 | 20 |
    When I submit the signup form
    Then i will get a '200' response
    And it should have a field 'status' containing 'OK'



Scenario: Retrieve user details
	
	Given a user with id '1'
	When i retrieve a user with id '1'
	Then i will get a '200' response 
	And the following details are returned:
		| email_address | fname  | lname | birthdate | age |
		| eloreinne@gmail.com | Loreinne | Estenzo | november 10, 1996 | 20 |


Scenario: Update user details
    Given a user with id no. '4' exist
    When I update the user details into the following:
    |user_id| email_address | fname | lname | password | birthdate | age |
    | 4 | clark@gmail.com | Dustin | Clark | miming | April 29, 1997 | 19 |
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'


Scenario: User already have an account
    Given the following information:
    | email_address | fname | lname | password | birthdate | age |
		| eloreinne@gmail.com | Loreinne | Estenzo | lala | November 10, 1996 | 20 |
    When I submit the signup form
    Then i will get a '200' response
    And it should have a field 'message' containing 'Error'



  Scenario: Signup User with email address empty
    Given the following information:
      | email_address | first_name | last_name | password | birthdate | age |
      |  | Mary| Cabz | mar123 | June 25,2016 | 20 |
    When I submit the signup form
    Then i will get a '200' response
    And it should have a field 'status' containing 'Error'


   Scenario: Signup User with first name empty
    Given the following information:
      | email_address | first_name | last_name | password | birthdate | age |
      | marcabz@gmail.com | | Cabz | mar123 | June 25,2016 | 20 |
    When I submit the signup form
    Then i will get a '200' response
    And it should have a field 'status' containing 'Error'


 Scenario: Signup User with last name empty
    Given the following information:
      | email_address | first_name | last_name | password | birthdate | age |
      | marcabz@gmail.com | Mary | | mar123 | June 25,2016 | 20 |
    When I submit the signup form
    Then i will get a '200' response
    And it should have a field 'status' containing 'Error'


 Scenario: Signup User with password empty
    Given the following information:
      | email_address | first_name | last_name | password | birthdate | age |
      | marcabz@gmail.com | Mary| Cabz | | June 25,2016 | 20 |
    When I submit the signup form
    Then i will get a '200' response
    And it should have a field 'status' containing 'Error'


Scenario: Signup User with birthdate empty
    Given the following information:
      | email_address | first_name | last_name | password | birthdate | age |
      | marcabz@gmail.com | Mary| Cabz | mar123 | | 20 |
    When I submit the signup form
    Then i will get a '200' response
    And it should have a field 'status' containing 'Error'
