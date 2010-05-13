Feature: <%= model %> sign up
  In order to get access to protected sections of the site
  An <%= model.downcase %>
  Should be able to sign up

  Scenario: <%= model.downcase.capitalize %> signs up with invalid data
    When I go to the <%= model.downcase %> sign up page
    And I fill in "Email" with "invalidemail"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with ""
    And I press "Sign up"
    Then I should see error messages

  Scenario: <%= model.downcase.capitalize %> signs up with valid data
    When I go to the <%= model.downcase %> sign up page
    And I fill in "Email" with "email@person.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign up"
    Then I should see "You have signed up successfully. A confirmation was sent your e-mail"
    And a confirmation message should be sent to <%= model.downcase %> "email@person.com"
    
  Scenario: <%= model.downcase.capitalize %> confirms his account
    Given I signed up as a <%= model.downcase %> with "email@person.com/password"
    When I follow the confirmation link sent to <%= model.downcase %> "email@person.com"
    Then I should see "Your account was successfully confirmed. You are now signed in"
    And I should be signed in as a <%= model.downcase %>
