class AddCommand < BaseCommand
  def run
    note = user.notes.new( text: message.text.sub(/^\/[^\s]+\s?/, '') )
    response_text = if note.save
      <<-TEXT.gsub(/^ +/, '')
        Note successfully saved with id #{note.id}.

        Please use /describe command if you want to attach tags and/or description.
        Example: /describe #read #romantic Book about love

        Created this note by mistake? Use the following command to delete it: /delete #{note.id}
      TEXT
    else
      "There were errors: #{note.errors.full_messages}"
    end

    respond_with(text: response_text)
  end
end