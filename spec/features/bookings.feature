Feature: Bookings management
  In order to book a resource
  As a user
  I want to be able to manage my bookings

  Scenario: Book a resource
    Given a signed in user
    When I go to the bookings page
    And I cannot see a disabled resource for booking
    And I can start to create a booking
    And I cannot book an available resource for more than 4 hours
    And I can book an available resource
    And I can see that the booking has been created
    And the manager should receive an email to notify the creation

  Scenario: Book a recurring resource
    Given a signed in user
    When I go to the bookings page
    And I can start to create a booking
    And I can book an available resource with weekly periodicity
    And I can see that the booking with weekly periodicity has been created
    And I cancel the booking
    And I can see that the booking with periodicity does not exists
    And I can start to create a booking
    And I can book an available resource with monthly periodicity
    And I can see that the booking with monthly periodicity has been created

  Scenario: Check my bookings
    Given a signed in user
    And an existing booking
    When I go to the bookings page
    Then I can see my bookings summary

  Scenario: Cancel a booking
    Given a signed in user
    And an existing booking
    When I go to the bookings page
    And I cancel the booking
    Then I can see that the booking does not exists
    And the manager should receive an email to notify the cancelation

  Scenario: Send feedback about a expired booking
    Given a signed in user
    When I go to the bookings page
    And I cannot see the feedback button in an old expired event
    And I click button to submit some feedback about a recently expired booking
    Then I can send a feedback message
    And I can see that the feedback have been submitted
