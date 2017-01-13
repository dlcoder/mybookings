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
    And I can see a bookings of a resource and all the info of them
    And I can cancel or reallocate a booking
    And I cannot see a disabled resource to reallocate a booking
    And I can reallocate a booking
    And I can cancel a booking
