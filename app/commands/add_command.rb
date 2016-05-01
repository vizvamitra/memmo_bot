class AddCommand < BaseCommand
  def run
    note = @user.notes.new( text: message.sub(/^\/[^\s]+\s?/, '').text )
    response_text = note.save ? "Note successfully saved" : "There were errors: #{note.errors.full_messages}"

    respond_with(text: response_text)
  end
end