Feature: Appointment



Scenario: Create a contract
    Given the following information:
        |event_id| client     | about          | app_date           |app_time | 
        |   1    | Ms Gonzales| some changes   | December 2, 2017   | 6:00 pm |

    When I click the add appointment button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'


