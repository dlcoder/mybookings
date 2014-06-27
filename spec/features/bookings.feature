Feature: Bookings management
  In order to book a resource
  As a user
  I want to be able to manage my bookings

  Scenario: Book a resource
    Given a signed in user
    When I go to the bookings page
    And I go to the new booking page
    And I can not see a disabled resource for booking
    And I can book an available resource
    And I can see that the booking has been created

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

  Scenario: Send feedback about a expired booking
    Given a signed in user
    When I go to the bookings page
    And I click button to submit some feedback about an expired booking
    Then I can send a feedback message
    And I can see that the feedback have been submitted
