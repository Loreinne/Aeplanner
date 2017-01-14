Feature: Add, View, Update Venue


    Scenario: Add new venue
        Given the following information:
        | v_name | v_email_address | v_description | v_location | v_capacity | v_pricing | v_categories |
        | Clarkson | clarkson@gmail.com | Nice,hahha | Paris | 200 | 100,000 | Wedding    |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'OK'


    Scenario: Get existing venue
        Given that a venue with id no. '4' exist
        When I retrieve a venue with id no. '4'
        Then i will get a '200' response
        And the following details are returned:
        | v_name | v_email_address | v_description | v_location | v_capacity | v_pricing | v_categories |
        | leila | leila@gmail.com | nice | iligan | 200 | 800000 | Wedding                 |


    Scenario: Update venue details
        Given that a venue with id no. '5' exist
        When I update the venue details into the following:
        |v_id| v_name | v_email_address | v_description | v_location | v_capacity | v_pricing | v_categories |
        |5| Britania |brit@gmail.com | nice | iligan | 200 | 800000 | Wedding                |
        Then I will get a '200' response
        And it should have a field 'status' containing 'OK'

    Scenario: Add Venue that already exist
        Given the following information:
        |v_id| v_name | v_email_address | v_description | v_location | v_capacity | v_pricing | v_categories |
        |4| leila | leila@gmail.com | nice | iligan | 200 | 800000 | Wedding                 |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'message' containing 'Error'


    Scenario: Add new venue with name field empty
        Given the following information:
        | v_name | v_email_address | v_description | v_location | v_capacity | v_pricing | v_categories |
        |  | hello@gmail.com | Nice,hahha | Paris | 200 | 100,000 | Wedding               |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new venue with description field empty
        Given the following information:
        | v_name | v_email_address | v_description | v_location | v_capacity | v_pricing | v_categories |
        | Clarkson | clarkson@gmail.com | | Paris | 200 | 100,000 | Wedding               |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new venue with location field empty
        Given the following information:
        | v_name | v_email_address | v_description | v_location | v_capacity | v_pricing | v_categories |
        | Clarkson | clarkson@gmail.com | Nice, hahaha | | 200 | 100,000     | Wedding    |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new venue with capacity field empty
        Given the following information:
        | v_name | v_email_address | v_description | v_location | v_capacity | v_pricing | v_categories |
        | Clarkson | clarkson@gmail.com |Nice, hahaha | Paris | | 100,000 | Wedding        |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'



    Scenario: Add new venue with pricing field empty
        Given the following information:
        | v_name | v_email_address | v_description | v_location | v_capacity | v_pricing | v_categories |
        | Clarkson | clarkson@gmail.com | Nice, hahaha | Paris | 200 | | Weddings         |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'

Scenario: Add new venue with email_address field empty
        Given the following information:
        | v_name | v_email_address | v_description | v_location | v_capacity | v_pricing | v_categories |
        | Clarkson | | Nice,hahha | Paris | 200 | 100,000 | Wedding                       |
        When I click the add button
        Then i will get a '200' response
        And it should have a field 'status' containing 'Error'