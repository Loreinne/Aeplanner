Feature: Add, retrieve and update event

  Scenario: Add new event
    Given the following information:
      | user_id | title | date_event | time_event |
      | 1 | Clark's Wedding| 2020-11-10 | 9:30 |
    When I add the event
    Then i will get a '200' response
    And it should have a field 'status' containing 'OK'


 Scenario: Get existing Event
    Given that an event with id no. '2' exist
    When I retrieve the event with id '2'
    Then i will get a '200' response
    And the following details are returned:
    | title | date_event | time_event |
    | Lea's Wedding| 2020-11-10 | 09:30:00 |


 Scenario: Update existing Event
    Given that an event with id no. '2' exist
    When I update event details with the following:
    | id | title | date_event | time_event |
    | 3 | Ikaii's Wedding| 2020-11-08 | 10:30 |
    Then i will get a '200' response
    And it should have a field 'status' containing 'OK'

 Scenario: Add new event with title field empty
    Given the following information:
      | user_id | title | date_event | time_event |
      | 1 | | 2020-11-10 | 9:30 |
    When I add the event
    Then i will get a '200' response
    And it should have a field 'status' containing 'Error'


  Scenario: Add new event with date_event field empty
    Given the following information:
      | user_id | title | date_event | time_event |
      | 1 | Clark's Wedding| | 9:30 |
    When I add the event
    Then i will get a '200' response
    And it should have a field 'status' containing 'Error'

  Scenario: Add new event with time_event field empty
    Given the following information:
      | user_id | title | date_event | time_event |
      | 1 | Clark's Wedding| 2020-11-10 | |
    When I add the event
    Then i will get a '200' response
    And it should have a field 'status' containing 'Error'



