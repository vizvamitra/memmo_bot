class DescribeCommand < BaseCommand
  def run
    if !note
      response_text = i18n(:no_notes)
    else
      tags = message.entities.hashtags.map(&:body)
      name = message.text.sub(/^\/[^\s]+\s?/, '').gsub(/#[^\s]+\s?/, '')

      response_text = i18n(update_note(tags, name) ? :success : :failure)
    end

    respond_with(text: response_text)
  end

  def note
    @note ||= @user.notes.recent.first
  end

  def update_note(tags, name)
    ActiveRecord::Base.transaction do
      begin
        tags = tags.map{ |t| Tag.find_or_create_by(name: t) }
        note.update(name: name) if name&.length > 0
        note.tags = tags
      rescue StandardError => e
        puts e.message
        puts e.backtrace
        raise ActiveRecord::Rollback
      end
    end
  end
end