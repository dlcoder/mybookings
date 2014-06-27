Feature: Admin
  In order to administer MyBookings
  As an administrator
  I want to be able to login in MyBookings

  Scenario: Manage resources as administrator
    Given a signed in administrator
    Then I go to the manage page
    And I click on Resources menu item
    And I can view a list of resources
    And I can disable a resource
    And I can enable a resource
    And I can add a new resource
    And I can see that the resource has been added
    And I can see a bookings of a resource and all the info of them

  Scenario: Manage resource types as administrator
    Given a signed in administrator
    Then I go to the manage page
    And I click on Resource types menu item
    And I can view a list of resource types
    And I can add a new resource type

  Scenario: Manage users as administrator
    Given a signed in administrator
    Then I go to the manage page
    And I click on Users menu item
    And I can view a list of users registered on MyBookings
    And I can edit an user
    And I can set the user as resource manager
    And I can assign the list of resource types that the user can manage
    And I can save the user
