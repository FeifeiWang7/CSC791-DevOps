Given /^I'm on the employer log in page$/ do
  visit ('/admins/sign_in')
end


When /^I fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in(field.gsub(' ', '_'), :with => value)
end


And /^I fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in(field.gsub(' ', '_'), :with => value)
end

And /^click a button "Log in$/ do|button|
  click_button button
end

Then /^I should see signed in successfully$/ do
  page.should have_content("Signed in successfully.")
end