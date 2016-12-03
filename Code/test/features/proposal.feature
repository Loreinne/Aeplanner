Feature: Proposal


Scenario: Create a Proposal
    Given the following information:
        |name        | address | proposal_num | proposal_name | proposal_date   |
        |Ma dela cruz| CDO     | 1            | Wedding       | October 3, 2016 |

    When I click the add button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'