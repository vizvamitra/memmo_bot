class AddCommand < BaseCommand
  def run
    note = user.notes.new( text: message.text.sub(/^\/[^\s]+\s?/, '') )

    response_text = if note.save
      i18n(:success, note_id: 1)
    else
      i18n(:failure, errors: note.errors.full_messages.join("\n"))
    end

    respond_with(text: response_text)
  end
end