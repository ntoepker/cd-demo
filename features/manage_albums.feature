Feature: Manage albums
  In order to build up a collection of albums
  A user
  Should be able to create, request, update and delete albums

    Scenario: User creates a new album
      Given no albums exist
      When I create an album "Thriller" by "Michael Jackson"
      Then I should have the album "Thriller" by "Michael Jackson"

    Scenario: User requests an album
      Given an album exists with title "Thriller" and artist "Michael Jackson"
      When I request the album "Thriller"
      Then I should see "Michael Jackson"

    Scenario: User updates an album
      Given an album exists with title "Thriller" and artist "Jackson Five"
      When I update the artist of the album "Thriller" with "Michael Jackson"
      Then I should see "Michael Jackson"

    Scenario: User deletes an album
      Given an album exists with title "Thriller" and artist "Michael Jackson"
      When I delete the album "Thriller"
      Then I should not see "Michael Jackson"
