Feature: <%= model %> Sign in
  In order to get access to protected sections of the site
  An <%= model.downcase %>
  Should be able to sign in

  Scenario: <%= model.downcase.capitalize %> is not signed up
    Given no <%= model.downcase %> exists with an email of "email@person.com"
    When I go to the <%= model.downcase %> sign in page
    And I sign in as <%= model.downcase %> "email@person.com/password"
    Then I should see "Invalid email or password"
    And I should not be signed in as a <%= model.downcase %> 

  Scenario: <%= model.downcase.capitalize %> enters wrong password
    Given I signed up as a <%= model.downcase %> with "email@person.com/password"
    When I go to the <%= model.downcase %> sign in page
    And I sign in as <%= model.downcase %> "email@person.com/wrongpassword"
    Then I should see "Invalid email or password"
    And I should not be signed in as a <%= model.downcase %>

  Scenario: <%= model.downcase.capitalize %> signs in successfully
    Given I signed up as a <%= model.downcase %> with "email@person.com/password"
    When I go to the <%= model.downcase %> sign in page
    And I sign in as <%= model.downcase %> "email@person.com/password"

    Then I should see "Signed in"
    And I should be signed in as a <%= model.downcase %>
