Feature: Manager
  In order to manage resources on MyBookings
  As a manager
  I want to be able to login in MyBookings

  Scenario: Manage resources as manager
    Given a signed in manager
    Then I go to the manage page
    And I click on Resources menu item
    And I can view a list of resources
    And I can disable a resource
    And I can enable a resource
    And I can add a new resource
    And I can see that the resource has been added
    And I can see the events of a resource and all the info of them
    And I can cancel or reallocate an event
    And I cannot reallocate the event to a disabled resource
    And I cannot reallocate the event to a resource with an overlapped booking
    And I can reallocate an event
    And I can cancel an event
    And the booking owner should receive an email with the cancellation reason
    And I can cancel a resource
    And I can see that the resource has been canceled
    And I can see that bookings with events associated with the cancelled resource has not been cancelled because they have events associated with another resource

  @javascript
  Scenario: See statistics as manager
    Given a signed in manager
    Then I go to the manage page
    And I click on Statistics menu item
    And I can view the available statistics
    And I can view the resource statistics
    And I can see the statistics only for the resources I can manage
