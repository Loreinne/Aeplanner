Feature: Login User

	Scenario: User login with valid details
		Given the following information:
		| email_address | password |
		| eloreinne@gmail.com | lala |
		When i click the login button
		Then i will get a '200' response 
		And it should have a field 'message' containing 'Successfully Logged In'