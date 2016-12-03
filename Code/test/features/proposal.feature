Feature: Proposal


Scenario: Create a Proposal
    Given the following information:
        |name        | address | proposal_num | proposal_name | proposal_date   |
        |Ma dela cruz| CDO     | 1            | Wedding       | October 3, 2016 |

    When I click the add propsal button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'



Scenario: Get Proposal
    Given a proposal id '1' is in the system 
    When I retrieve the proposal '1'
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'
    And the following proposal details are returned:
        |id |name        | address | proposal_num  | proposal_name | proposal_date   |
        |1  |Balds       | Baguio  | birthday party| 2             | August 2, 2017  |