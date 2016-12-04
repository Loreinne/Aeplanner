Feature: Note


Scenario: Add a note
    Given the following information:
        |title               | note   |             
        |Wedding Preparation | the theme is vintage |

    When I click the add note button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'

