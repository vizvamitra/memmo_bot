Feature: /tags command

  As a memmo_bot user
  I want to be able to list all my existing tags
  In order to get an overview

  Scenario: User requests to list existing tags

    Given user "Mike" has following notes:
      |            text |          tags |
      |       Some note | #example #tag |
      | Some other note | #another #tag |
      | Some other note |     #eat #art |
    When "Mike" sends "/tags" command
    Then bot should respond with the following text:
      ```
      Existing tags:

      <strong>A</strong>
      #another #art

      <strong>E</strong>
      #eat #example

      <strong>T</strong>
      #tag
      ```
    And parse mode should be "HTML"