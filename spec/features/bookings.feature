Feature: Bookings management
  In order to book a resource
  As a user
  I want to be able to manage my bookings

  @javascript
  Scenario: Book a resource
    Given a signed in user
    When I go to the bookings page
    Then I can book a resource
    And I can see that the booking has been created

  Scenario: Check my bookings
    Given an existing booking
    When I go to the bookings page
    Then I can see the booking summary

  Scenario: Cancel a booking
    Given a signed in user
    And an existing booking
    When I go to the bookings page
    Then I can cancel the booking
    And I can see that the booking has been removed
