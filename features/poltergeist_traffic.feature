Feature: Check GA on page


Scenario: Check google analytics loaded on the page with Poltergeist

  Given I visit any website to track google analytics
  When I call network traffic
  Then I should see page traffic loaded in the file
  And I should see google-analytics in the file
