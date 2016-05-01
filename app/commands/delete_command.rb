class DeleteCommand < BaseCommand
  def run
    id = message.text.gsub(/^\/[^\s]+\s?/, '').to_i
    note = user.notes.find_by(id: id)

    if note
      note.destroy
      response_text = "Success"
    else
      response_text = "Note not found"
    end

    respond_with({text: response_text})
  end
end