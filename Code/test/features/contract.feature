Feature: Contract
	


Scenario: Create a contract
    Given the following information
    | id | reference | client name| termsOfAgreement|
    |  1 |    Auth   | Ms Reyes   | Termination of registration |

    When I click the contract button
    Then it should have a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'Successfully created a Contract'