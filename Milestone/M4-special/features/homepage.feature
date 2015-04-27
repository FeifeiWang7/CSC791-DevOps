 Feature: Home Dashboard 
  
  Scenario: Jobseeker Login
    Given I'm on the home page
    When I go to Job Seeker Login
    Then I should see Emails and Password are required to log in as a job seeker

   Scenario: Employer Login
     Given I'm on the home page
     When I go to Employer Login
     Then I should see Emails and Password are required to log in as an employer

   Scenario: Admin Login
     Given I'm on the home page
     When I go to Admin Login
     Then I should see Emails and Password are required to log in as an admin

   Scenario: Contact
     Given I'm on the home page
     When I go to Contact Us
     Then I should see contact information