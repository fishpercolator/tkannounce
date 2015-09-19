Feature: Announcements

  In order to be kept informed of the best food in Leeds
  As a Twitter user
  I want a tweet every time a new vendor appears at Trinity Kitchen

  Scenario: New vendor appears
    Given the stored information is already up-to-date
    When a new vendor appears with the name 'Marshmallow Mountain'
    And the scheduled task runs
    Then I should see a tweet announcing 'Marshmallow Mountain'
