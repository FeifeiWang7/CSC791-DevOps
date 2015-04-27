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
