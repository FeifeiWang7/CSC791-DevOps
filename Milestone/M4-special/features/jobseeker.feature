Feature: JobSeeker

  Scenario: Log in
    Given: I'm on the jobseeker log in page
    When: I fill in "std1@hotmail.com" with "Email"
    And: I fill in "12345678" with "Password"
    And: click a button "Log in"
    Then: I should see signed in successfully
