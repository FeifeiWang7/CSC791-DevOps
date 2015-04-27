Feature: Employer

  Scenario: Log in
    Given: I'm on the employer log in page
    When: I fill in "employer@employer.com" with "Email"
    And: I fill in "12345678" with "Password"
    And: click a button "Log in"
    Then: I should see signed in successfully

    Given: I'm on the employer log in page
    When: I fill in "empencsu@gmail.com" with "Email"
    And: I fill in "project1" with "Password"
    And: click a button "Log in"
    Then: I should see signed in successfully

    Given: I'm on the employer log in page
    When: I fill in "abc@yahoo.com" with "Email"
    And: I fill in "12345678" with "Password"
    And: click a button "Log in"
    Then: I should see signed in successfully