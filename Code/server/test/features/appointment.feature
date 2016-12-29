Feature: Appointment



Scenario: Create an appointment
    Given the following information of an appointment:
        |event_id| client     | about          | app_date           |app_time | 
        |   1    | Ms Go| some changes   | December 2, 2017   | 9:00   |

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


Scenario: Update Appointment
    Given a appointment '4' is in the system with the following details:
        |  id    | client     | about                 | app_date           |app_time      | 
        |   4    | Yassi Lee  | important matters     |   January 3, 2017  |   9:00      |

    And the new appointment information for appointment id '4'
        |  id    | client     | about                 | app_date           |app_time      | 
        |   4    | Yassi Lee  | change location       |   January 30, 2017 |   10:00      |

    When I click the update appointment button
    Then I will get a '200' response
    And it should have a field 'status' containing 'OK'
    And it should have a field 'message' containing 'OK'