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

Scenario: Create an appointment with client field empty 
    Given the following information of an appointment:
        |event_id| client     | about          | app_date           |app_time | 
        |   1    | 			  | some changes   | December 2, 2017   | 9:00   |

    When I click the add appointment button
    Then I will get a '200' response
    And it should have a field 'status' containing 'Error'
    And it should have a field 'message' containing 'Error'


Scenario: Create an appointment with about field empty 
    Given the following information of an appointment:
        |event_id| client     | about          | app_date           |app_time | 
        |   1    | Maria Cruz | 			   | December 2, 2017   | 9:00   |

    When I click the add appointment button
    Then I will get a '200' response
    And it should have a field 'status' containing 'Error'
    And it should have a field 'message' containing 'Error'

Scenario: Create an appointment with appointment date field empty 
    Given the following information of an appointment:
        |event_id| client     | about                 | app_date           |app_time | 
        |   1    | Maria Cruz | important matters     |                    | 9:00   |

    When I click the add appointment button
    Then I will get a '200' response
    And it should have a field 'status' containing 'Error'
   

Scenario: Create an appointment with appointment timefield empty 
    Given the following information of an appointment:
        |event_id| client     | about                 | app_date           |app_time | 
        |   1    | Maria Cruz | important matters     |   August 13, 2017  |         |

    When I click the add appointment button
    Then I will get a '200' response
    And it should have a field 'status' containing 'Error'
    

Scenario: Get Appointment
    Given a appointment id '1' is in the system 
    When I retrieve the appointment '1'
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'
    And the following appointment details are returned:
        |  id    | client     | about                 | app_date           |app_time      | 
        |   1    | Luis Yap   | important matters     |   August 13, 2017  |   10:00      |