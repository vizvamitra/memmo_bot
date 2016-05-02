class DeleteCommand < BaseCommand
  def run
    id = message.text.gsub(/^[^\d]+/, '').to_i
    note = user.notes.find_by(id: id)

    response_text = i18n( note&.destroy ? :success : :failure )

    respond_with( text: response_text )
  end
end