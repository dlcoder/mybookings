Feature: Users
  In order to use MyBookings
  As a user
  I want to be able to login in MyBookings

  Scenario: Login as an unexisting user
    When I visit the homepage
    And I go to the sign up page
    Then I can sign up
    And I can see that I have signed up
    And I can see my bookings page

  Scenario: Login as an existing user
    Given a registered user
    When I visit the homepage
    Then I can sign in
    And I can see that I have signed in
    And I can see my bookings page

  Scenario: Login with saml as an unexisting user
    When I visit the homepage
    And I go to the sign in with saml page
    And I can see that I have signed in with saml
    And I can see my bookings page

  Scenario: Login with saml as an existing user
    Given a registered user
    When I visit the homepage
    And I go to the sign in with saml page
    And I can see that I have signed in with saml
    And I can see my bookings page

  Scenario: Logout
    Given a signed in user
    When I go to sign out
    Then I can see that I have signed out
    And I can see the homepage
