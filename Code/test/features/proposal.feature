Feature: Proposal


Scenario: Create a Proposal
    Given the following information of a proposal:
        |name        | address | proposal_num | proposal_name | proposal_date   |
        |Ma dela cruz| CDO     | 1            | Wedding       | October 3, 2016 |

    When I click the add proposal button
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



Scenario: Update Proposal
    Given a proposal id '3' is in the system with the following information:
        |id |name        | address | proposal_num  | proposal_name | proposal_date   |
        |3  | Cris Reyes | Cebu    | 1             | Seminar       | December 3, 2017            |
    And the new proposal information for proposal id '3'
        |id |name        | address | proposal_num  | proposal_name | proposal_date   |
        |3  | Cris Reyes | Cebu    | 2              | Seminar      | January 5, 2018            |
    When I click the update proposal button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'



