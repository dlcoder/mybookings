Feature: Bookings management
  In order to book a resource
  As a user
  I want to be able to manage my bookings

  @javascript
  Scenario: Book a resource
    Given a signed in user
    When I go to the bookings page
    And I can start to create a booking
    And I cannot book an available resource for more than 4 hours
    And I can book an available resource
    And I can see that the booking has been created
    And the manager should receive an email to notify the creation
    And the user should receive an email to notify the creation

  @javascript
  Scenario: Book a recurring resource
    Given a signed in user
    When I go to the bookings page
    And I can start to create a booking
    And I can book an available resource with weekly periodicity
    And the user should receive an email to notify the creation
    And the manager should receive an email to notify the creation
    And I can see that the booking with weekly periodicity has been created
    And I go to the bookings page
    And I can see the weekly booking details
    And I can cancel the booking
    And the manager should receive an email to notify the cancelation
    And I can see that the booking with periodicity does not exists
    And I can start to create a booking
    And I can book an available resource with monthly periodicity
    And the manager should receive an email to notify the creation
    And the user should receive an email to notify the creation
    And I can see that the booking with monthly periodicity has been created

  @javascript
  Scenario: Send feedback about a expired booking
    Given a signed in user
    When I go to the bookings page
    And I visit the booking details for a old expired event
    And I cannot submit feedback
    And I go to the bookings page
    And I visit the booking details for a recently expired event
    And I can submit feedback
    And I can see that the feedback has been submitted
