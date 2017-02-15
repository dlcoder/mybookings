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

  @javascript
  Scenario: Book a recurring resource
    Given a signed in user
    When I go to the bookings page
    And I can start to create a booking
    And I can book an available resource with weekly periodicity
    And the manager should receive an email to notify the creation
    And I can see that the booking with weekly periodicity has been created
    And I go to the bookings page
    And I can see the booking details
    And I can cancel the booking
    And the manager should receive an email to notify the cancelation
    And I can see that the booking with periodicity does not exists
    And I can start to create a booking
    And I can book an available resource with monthly periodicity
    And the manager should receive an email to notify the creation
    And I can see that the booking with monthly periodicity has been created

  @wip
  @javascript
  Scenario: Send feedback about a expired booking
    Given a signed in user
    When I go to the bookings page
    And an existing booking
    And I go to the bookings page
    And I can see the booking details
    And I cannot see the feedback button in an old expired event
    And I click button to submit some feedback about a recently expired booking
    Then I can send a feedback message
    And I can see that the feedback have been submitted
