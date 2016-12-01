Feature: Signup User

  Scenario: Signup System Admin
    Given the following information:
      | email_address | first_name | last_name | password |
      | m@gmail.com | Marjorie | Buctolan | marj123 |
    When I submit the signup form
    Then it should have a '200' response
    And it should have a field 'status' containing 'OK'
