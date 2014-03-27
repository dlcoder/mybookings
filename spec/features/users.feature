Feature: Users
  In order to use MyBookings
  As a user
  I want to be able to sign up and sign in

  Scenario: signin up
    When I visit the homepage
    And I go to the sign up page
    Then I can sign up
    And I can see that I have signed up
    And I can see my bookings page
    And I can sign out
    And I can see that I have signed out
    And I can see the homepage

  Scenario: signin in and out
    Given a registered user
    When I visit the homepage
    And I go to the sign in page
    Then I can sign in
    And I can see that I have signed in
    And I can see my bookings page
    And I can sign out
    And I can see that I have signed out
    And I can see the homepage
