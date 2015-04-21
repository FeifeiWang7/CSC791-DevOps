Feature: Admin

  Scenario: Log in
    Given: I'm on the admin log in page
    When: I fill in "admin@admin.com" with "Email"
    And: I fill in "12345678" with "Password"
    And: click a button "Log in"
    Then: I should see signed in successfully

    Given: I'm on the admin log in page
    When: I fill in "admin2@admin.com" with "Email"
    And: I fill in "12345678" with "Password"
    And: click a button "Log in"
    Then: I should see signed in successfully

  Scenario: Create admins
	Given: I'm on the create admins page
	When: I fill in "admin1@admin.com" with "Email"
	And: I fill in "12345678" with "Password"
	And: I fill in "12345678" with "Password confirmation"
	And: click a button "Sign up"
	Then: I should see signed up successfully

	Given: I'm on the create admins page
        When: I fill in "admin1@admin.com" with "Email"
        And: I fill in "12345678" with "Password"
        And: I fill in "123456789" with "Password confirmation"
        And: click a button "Sign up"
        Then: I should see signed up successfully

