Feature: /list command

  As a memmo_bot user
  I want to be able to list all my notes
  In order to get my data

  Scenario: User requests to list his notes

    Given user "Mike" has following notes:
      |                text |          tags |      comment | created_at |
      | Note with full data | #example #tag | some comment | 28.05.2016 |
    When "Mike" sends "/list" command
    Then bot should respond with the following text:
      ```
      Recent notes:

      📄 <strong>some comment</strong>
      #example #tag
      Note with full data

      ```
    And parse mode should be "HTML"



  Scenario: Displaying notes which lacks comments and\or tags

    Given user "Mike" has following notes:
      |                   text |           tags |   comment | created_at |
      |      Note without tags |                | blah-blah | 30.05.2016 |
      | Note without a comment | #example #todo |           | 29.05.2016 |
      |  Note with only a text |                |           | 28.05.2016 |
    When "Mike" sends "/list" command
    Then bot should respond with the following text:
      ```
      Recent notes:

      📄 <strong>blah-blah</strong>
      Note without tags

      📄 #example #todo
      Note without a comment

      📄 Note with only a text

      ```


  Scenario: Displaying notes with a to lengthy text

    Given user "Mike" has following note:
      |          id|             15 |
      |       text | Very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very long text |
      |       tags |    #tag1 #tag2 |
      |    comment | blah-blah-blah |
      | created_at |     30.05.2016 |
    When "Mike" sends "/list" command
    Then bot should respond with the following text:
      ```
      Recent notes:

      📄 <strong>blah-blah-blah</strong>
      #tag1 #tag2
      Very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very...

      Show full message: /show_15

      ```
