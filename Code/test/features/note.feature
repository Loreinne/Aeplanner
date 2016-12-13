Feature: Note


Scenario: Add a note
    Given the following information of a note:
        |event_id|title              |note               |             
        |    1   |Wedding Preparation|the theme is vintage |

    When I click the add note button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'

Scenario: Add a note that already exists
    Given the following information of a note:
        |event_id|title              |note               |             
        |    1   |Wedding Preparation|the theme is vintage |

    When I click the add note button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'note already exist'

Scenario: Add a note with title field empty
    Given the following information of a note:
        |event_id|title              |note               |             
        |    1   |                   |the theme is vintage |

    When I click the add note button
    Then I will get a '200' response
    And it should have a field 'status' containing 'Error'
    And it should have a field 'message' containing 'Error'

Scenario: Add a note with note field empty
    Given the following information of a note:
        |event_id|title              |note               |             
        |    1   | Anniversary       |                   |

    When I click the add note button
    Then I will get a '200' response
    And it should have a field 'status' containing 'Error'
    And it should have a field 'message' containing 'Error'

Scenario: Get Note
    Given a note id '1' is in the system
    When I retrieve the note id '1'
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'
    And the following note details are returned:
        | id  |   title          |   note                  |
        | 1   | Beach Party Prep | the theme color is pink |



Scenario: Update Note
    Given a note '6' is in the system with the following details:
        |  id | title               |  note                      |
        | 6   | Birthday Party Prep | Theme is disney princesses |

    And the new note information for note id '6'
        | id  |   title          |   note            |
        | 6   | Anniversary Prep | simple but classy |

    When I click the update note button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'