Given /^no (.+?) exists with an email of "(.*)"$/ do |authenticable, email|
  assert_nil authenticable.camelize.constantize.find_by_email(email)
end

Given /^I am signed in as the (.+?) with credentials "(.*)\/(.*)"$/ do |authenticable, email, password|
  user = Factory authenticable.to_sym, :email => email, :password => password, :password_confirmation => password
  user.confirm! if user.respond_to?(:confirm!) 
  sign_in_step = "I sign in as #{authenticable} \"#{email}/#{password}\""
  When sign_in_step
end


Given /^I signed up as a (.+?) with "(.*)\/(.*)"$/ do |authenticable, email, password|
  user = Factory authenticable.to_sym, :email => email, :password => password, :password_confirmation => password
end

Given /^I am signed up and confirmed as (.+?) "(.*)\/(.*)"$/ do |authenticable, email, password|
  user = Factory authenticable.to_sym, :email => email, :password => password, :password_confirmation => password
  user.confirm!
end

When /^I sign in( with "remember me")? as (.+?) "(.*)\/(.*)"$/ do |remember, authenticable, email, password|
  When %{I go to the #{authenticable} sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I check "Remember me"} if remember
  And %{I press "Sign in"}
end

Then /^I should not be signed in as a (.+?)$/ do |authenticable|
  email_path = send("new_#{authenticable}_password_path")
  page.should have_css("a[href='#{email_path}']")
end

Then /^I should be signed in as a (.+?)$/ do |authenticable|
  login_path = send("new_#{authenticable}_session_path")
  logout_path = send("destroy_#{authenticable}_session_path")
  page.should_not have_css("a[href='#{login_path}']")
  page.should have_css("a[href='#{logout_path}']")
end

# This isn't a very good way to test this but capybara's abstraction
# means I can't directly clear the session
When /^I return next time$/ do
  When %{I go to the homepage}
end

Then /^I should see error messages$/ do
  page.should have_css('div[id=error_explanation]')
end

When /^I follow the confirmation link sent to (.+?) "([^\"]*)"$/ do |authenticable, email|
  user = authenticable.camelize.constantize.find_by_email(email)
  method = "#{authenticable}_confirmation_path"
  visit send(method, :confirmation_token => user.confirmation_token)
end

Then /^a confirmation message should be sent to (.+?) "([^\"]*)"$/ do |authenticable, email|
  user = authenticable.camelize.constantize.find_by_email(email)
  sent = ActionMailer::Base.deliveries.last
  assert_equal [email], sent.to
  assert_match /confirm/i, sent.subject
  assert !user.confirmation_token.blank?
  
  if sent.parts.size == 1
    text_component = sent.body
  else
    text_component = sent.parts.find { |p| p.content_type.match("text/plain") }.body.to_s
  end
  
  assert_match /#{user.confirmation_token}/, text_component
end

