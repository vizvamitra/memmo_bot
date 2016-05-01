class HelpCommand < BaseCommand
  def run
    response_text = <<-TEXT.gsub(/^ +/, '')
      My name is Memmo and I can memorize some notes for you.

      Here is the list of commands that I understand:

      /add [text] - Create a new note
      Example: /add http://example.com/blah-blah

      /describe [tags] [name] - Describe last created note
      Example: /describe #url #example Example website

      /last [number] - Show given number of recently added notes
      Example: /last 5

      /tags - Show list of existing tags
      Example: /tags

      /delete [id] - Delete note with a given id
      Example: /delete 1764

      Hope you enjoy using me. Please write to my creator Dmitrii Krasnov at vizvamitra@gmail.com if you have any suggestions or (Oh no!) encountered a bug.
    TEXT

    respond_with(text: response_text)
  end
end