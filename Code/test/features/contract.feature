Feature: Contract
	


Scenario: Create a contract
    Given the following information:
        | reference | client_name| termsOfAgreement|
        |    Auth   | Ms Reyes   | Termination of registration |

    When I click the contract button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'


Scenario: Get a contract
    Given a contract '1' is in the system
    When I retrieve the contract '1'
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'
    And the following contract details are returned:
        | id  | reference | client_name  | termsOfAgreement |
        | 1   | google    | Mr Cruz      | Registration     |


Scenario: Update contract  
    Given the contract id '2' is in the system with the following information:
        |id |reference | client_name | termsOfAgreement |
        |2  | Google   | Kyla Gomez  | Privacy          |
    And the new contract information for contract id '2'
        |id | reference | client_name | termsOfAgreement |
        |2  | auth      | Kyla Gomez | registration     |

    When I click the update button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'