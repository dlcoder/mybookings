Feature: Manager
  In order to manage resources on MyBookings
  As a manager
  I want to be able to login in MyBookings

  Scenario: 
    Given a signed in manager
    Then I go to the manage page
    And I click on Resources menu item
    And I can view a list of resources
    And I can disable a resource
    And I can enable a resource
    And I can add a new resource
    And I can see that the resource has been added
