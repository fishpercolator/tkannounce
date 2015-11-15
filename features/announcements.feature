Feature: Announcements

  In order to be kept informed of the best food in Leeds
  As a Twitter user
  I want a tweet every time a new vendor appears at Trinity Kitchen

  Scenario: Initial run
    Given the database is empty
    And there are 3 vendors in TK
    When the scheduled task runs
    Then the database should contain 3 items
    And 3 tweets should be posted

  Scenario: No changes
    Given the database contains 6 items
    When the scheduled task runs
    Then no tweet should be posted

  Scenario: New vendor appears
    Given the database contains 6 items
    When a new vendor appears with the name 'Marshmallow Mountain'
    And the scheduled task runs
    Then 1 tweet should be posted announcing 'Marshmallow Mountain'
    And the database should contain 'Marshmallow Mountain'

  Scenario: Vendor disappears
    Given the database contains 6 items
    When a vendor disappears with the name 'Marshmallow Mountain'
    And the scheduled task runs
    Then no tweet should be posted
    And the databas eshould contain 5 items
