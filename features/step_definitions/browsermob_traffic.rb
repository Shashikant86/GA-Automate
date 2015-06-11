Given(/^I setup browsermob proxy$/) do
  File.delete('website.har') if File.exist?('website.har')
  File.delete('har.yml') if File.exist?('har.yml')
end

When(/^I run browsermob proxy$/) do
  system('ruby browser-mob.rb')
end

Then(/^I should see har file generated$/) do
  expect(File).to exist("website.har")
end

When(/^I parse har file$/) do
  @data = system('ruby har_parser.rb website.har')
end

Then(/^I should see google analytics variable in yml file$/) do
  File.exist?('har.yml')
end
