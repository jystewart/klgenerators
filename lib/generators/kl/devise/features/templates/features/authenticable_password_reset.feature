Feature: Sign in
  In order to get access to protected sections of the site
  A <%= model.downcase %>
  Should be able to sign in

  Background:
    Given I am signed up and confirmed as <%= model.downcase %> "email@person.com/password"

  Scenario: <%= model %> requests new password
    When I go to the <%= model.downcase %> new password page
    And I fill in "Email" with "email@person.com"
    And I press "Send me reset password instructions"

    Then a password reset email should be sent to <%= model.downcase %> "email@person.com"
    And I should see "You will receive an email"

  Scenario: <%= model %> follows link to reset password
    Given I requested a new password for the <%= model.downcase %> with email "email@person.com"
    
    When I follow the link in the password reset email for <%= model.downcase %> "email@person.com"
    And I fill in "<%= model.downcase %>_password" with "newpassword"
    And I fill in "Password confirmation" with "newpassword"
    And I press "Change my password"
    
    Then I should be on the homepage
    And I should see "Your password was changed successfully. You are now signed in."
    And the password for <%= model.downcase %> "email@person.com" should be "newpassword"