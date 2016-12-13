Feature: Appointment



Scenario: Create an appointment
    Given the following information of an appointment:
        |event_id| client     | about          | app_date           |app_time | 
        |   1    | Ms Gonzales| some changes   | December 2, 2017   | 9:00   |

    When I click the add appointment button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'


Scenario: Create an appointment that already exists
    Given the following information of an appointment:
        |event_id| client     | about          | app_date           |app_time | 
        |   1    | Ms Gonzales| some changes   | December 2, 2017   | 9:00   |

    When I click the add appointment button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'Appointment exist'