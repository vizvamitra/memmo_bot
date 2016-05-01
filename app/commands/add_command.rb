class AddCommand < BaseCommand
  def run
    note = @user.notes.new( text: message.text.sub(/^\/[^\s]+\s?/, '') )
    response_text = note.save ? "Note successfully saved" : "There were errors: #{note.errors.full_messages}"

    respond_with(text: response_text)
  end
end