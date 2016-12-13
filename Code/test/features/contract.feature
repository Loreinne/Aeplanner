Feature: Contract
	


Scenario: Create a contract
    Given the following information:
        |event_id | contract_reference | client_name| termsOfAgreement            |
        |     1   |    Auth   | Ms Reyes   | Termination of registration |

    When I click the add contract button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'

Scenario: Create a contract that already exists
    Given the following information:
        |event_id  | contract_reference | client_name| termsOfAgreement            |
        |     1    |    Auth   | Ms Reyes   | Termination of registration |

    When I click the add contract button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'contract exists'


Scenario: Create a contract with reference field empty
    Given the following information:
        |event_id  | contract_reference | client_name| termsOfAgreement|
        |     1    |           | Ms Cruz    | Termination of registration |

    When I click the add contract button
    Then I will get a '200' response
     And it should have a field 'status' containing 'Error'

Scenario: Create a contract that with client name field empty 
    Given the following information:
        |event_id   | contract_reference | client_name| termsOfAgreement|
        |     1     |    Auth            |            | Termination of registration |

    When I click the add contract button
    Then I will get a '200' response
    And it should have a field 'status' containing 'Error'
    
Scenario: Create a contract that with terms of agreement field empty 
    Given the following information:
        |event_id  | contract_reference | client_name| termsOfAgreement|
        |     1    |    Auth            | Ms Lee     |                 |

    When I click the add contract button
    Then I will get a '200' response
    And it should have a field 'status' containing 'Error'
    

Scenario: Get a contract
    Given a contract '1' is in the system
    When I retrieve the contract '1'
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'
    And the following contract details are returned:
        | id  | contract_reference | client_name  | termsOfAgreement |
        | 1   | google             | Mr Cruz      | Registration     |



Scenario: Update contract  
    Given a contract id '2' is in the system with the following information:
        |id |contract_reference | client_name | termsOfAgreement |
        |2  | Google            | Kyla Gomez  | Privacy          |
    And the new contract information for contract id '2'
        |id | contract_reference | client_name | termsOfAgreement |
        |2  | auth               | Kyla Gomez | registration     |

    When I click the update contract button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'

