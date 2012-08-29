Feature: Search
  In order to find the desired music
  A user
  Should be able to search and find

    Scenario: User searches for an existing album title
      Given an album exists with title "Thriller" and artist "Michael Jackson"
      When I search for "Thriller"
      Then I should find the album "Thriller" by "Michael Jackson"

    Scenario: User searches for an existing artist
      Given an album exists with title "Thriller" and artist "Michael Jackson"
      When I search for "Jackson"
      Then I should find the album "Thriller" by "Michael Jackson"

    Scenario: User searches for something unknown
      Given an album exists with title "Thriller" and artist "Michael Jackson"
      When I search for "Madonna"
      Then I should see "not found"
