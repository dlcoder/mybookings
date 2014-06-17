Feature: Admin
  In order to administer MyBookings
  As an administrator
  I want to be able to login in MyBookings

  Scenario: Manage resources as administrator
    Given a signed in administrator
    Then I go to the administer page
    And I click on Resources menu item
    And I can view a list of resources
    And I can disable a resource
    And I can enable a resource
