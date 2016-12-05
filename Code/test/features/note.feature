Feature: Note


Scenario: Add a note
    Given the following information of a note:
        |n_title            |n_note               |             
        |Wedding Preparation|the theme is vintage |

    When I click the add note button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'


Scenario: Get Note
    Given a note id '1' is in the system
    When I retrieve the note id '1'
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'
    And the following note details are returned:
        |n_id | n_title          | n_note                  |
        | 1   | Beach Party Prep | the theme color is pink |

        