class GetCommand < BaseCommand
  def run
    tags = message.entities.hashtags.map(&:body)
    notes = user.notes.recent.joins(:tags).where('tags.name in (?)', tags).group('notes.id').preload(:tags)

    response_text = "#{ i18n(:caption, notes_count: notes.to_a.tount) }\n\n"

    notes.each do |note|
      response_text << "<strong>#{note.name}</strong>\n" if note.name
      tags_string = note.tags.map{|tag| "##{tag.name}"}.join(' ')
      response_text << "#{tags_string}\n" if tags_string.length > 0

      response_text << "\n#{note.text}\n"
      response_text << i18n(:delete, note_id: note.id)
      response_text << "\n\n" unless note == notes[-1]
    end

    respond_with(text: response_text, parse_mode: 'HTML', disable_web_page_preview: true)
  end
end