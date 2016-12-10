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



Scenario: Update Note
    Given a note '6' is in the system with the following details:
        |n_id | n_title             | n_note                      |
        | 6   | Birthday Party Prep | Theme is disney princesses |

    And the new note information for note id '6'
        |n_id | n_title          | n_note            |
        | 6   | Anniversary Prep | simple but classy |

    When I click the update note button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'