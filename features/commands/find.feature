Feature: /find command

  As a memmo_bot user
  I want to be able to search my notes by tag
  In order to get my data

  Background:

    Given user "Mike" has following notes:
      | id |       text |            tags |      comment | created_at |
      | 10 |   Buy eggs |           #todo |   Honey said | 27.05.2016 |
      | 11 |   Buy milk | #todo #milkshop | Milk is cool | 28.05.2016 |
      | 12 | Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life s |         #wisdom |  Just a joke | 21.05.2016 |


  Scenario: User searches note by tag

    Notes are being returned ordered by creation date descending

    When "Mike" sends "/find #todo" command
    Then bot should respond with the following text:
      ```
      I found 2 notes:

      📄 <strong>Milk is cool</strong>
      #todo #milkshop
      Buy milk

      📄 <strong>Honey said</strong>
      #todo
      Buy eggs

      ```
    And parse mode should be "HTML"



  Scenario: User searches by several tags

    When "Mike" sends "/find #todo #milkshop" command
    Then bot should respond with the following text:
      ```
      I found 1 notes:

      📄 <strong>Milk is cool</strong>
      #todo #milkshop
      Buy milk

      ```
    And parse mode should be "HTML"



  Scenario: Search result contains note with too lengthy text

    When "Mike" sends "/find #wisdom" command
    Then bot should respond with the following text:
      ```
      I found 1 notes:

      📄 <strong>Just a joke</strong>
      #wisdom
      Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks Life sucks...

      Show full message: /show_12

      ```
    And parse mode should be "HTML"

