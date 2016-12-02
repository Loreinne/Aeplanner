Feature: Contract
	


Scenario: Create a contract
    Given the following information:
        | reference | client_name| termsOfAgreement|
        |    Auth   | Ms Reyes   | Termination of registration |

    When I click the contract button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'Successfully created a Contract'


Scenario: Get a contract
    Given a contract '1' is in the system
    When I retrive the contract '1'
    Then I will get a '200' response
    And the following contract details are returned:
    | id | reference | client_name  | termsOfAgreement |
    | 1  | google    | Ms Dela Cruz | Termination      |