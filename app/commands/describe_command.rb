class DescribeCommand < BaseCommand
  def run
    if !note
      response_text = "Please create at least one note first"
    else
      tags = message.entities.select{|e| e.type == 'hashtag'}
      name = message.text.sub(/^\/[^\s]+\s?/, '').gsub(/#[^\s]+\s/, '')

      response_text = update_note(tags, name) ? "Success" : "Failure =(. Sorry for that."
    end

    respond_with(text: response_text)
  end

  def note
    @note ||= @user.notes.recent.first
  end

  def update_note(tags, name)
    ActiveRecord::Base.transaction do
      begin
        tags = tags.map{ |t| Tag.find_or_create_by(name: t.body) }
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