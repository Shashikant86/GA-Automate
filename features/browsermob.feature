Feature: Browsermob


Scenario: Check proxy with browsermob

   Given I setup browsermob proxy
   When I run browsermob proxy
   Then I should see har file generated
   When I parse har file
   Then I should see google analytics variable in yml file
