Feature: Admin
  In order to administer MyBookings
  As an administrator
  I want to be able to login in MyBookings

  @javascript
  Scenario: Manage resources as administrator
    Given a signed in administrator
    Then I go to the manage page
    And I click on Resources menu item
    And I can view a list of resources
    And I can disable a resource
    And I can enable a resource
    And I can add a new resource
    And I can see that the resource has been added
    And I can see the events of a resource
    And I can visit the booking details page of an event
    And I can see that I can cancel or reallocate an event
    And I cannot reallocate the event to a disabled resource
    And I cannot reallocate the event to a resource with an overlapped booking
    And I can reallocate an event
    And I can cancel an event
    And the booking owner should receive an email with the cancellation reason
    And I can cancel a resource
    And I can see that the resource has been canceled
    And I can see that bookings with events associated with the cancelled resource has not been cancelled because they have events associated with another resource

  Scenario: Manage resource types as administrator
    Given a signed in administrator
    Then I go to the manage page
    And I click on Resource types menu item
    And I can view a list of resource types
    And I can add a new resource type
    And I can edit a resource type
    And I can change the name of the resource type
    And I can update the resource type
    And I can cancel the resource type
    And I can see that the resource type has been cancelled
    And I can see that the resources associated with the resource type has been canceled

  Scenario: Manage users as administrator
    Given a signed in administrator
    Then I go to the manage page
    And I click on Users menu item
    And I can view a list of users registered on MyBookings
    And I can edit an user
    And I can set the user as resource manager
    And I can assign the list of resource types that the user can manage
    And I can save the user
    And I can create a new user
    And I can see that the user has been created
    And I can search for an user
    And I can see the results of the search

  @javascript
  Scenario: See statistics as administrator
    Given a signed in administrator
    Then I go to the manage page
    And I click on Statistics menu item
    And I can view the available statistics
    And I can view the resource statistics
    And I can see the statistics for all available resources
