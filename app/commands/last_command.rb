class LastCommand < BaseCommand
  def run
    count = message.text.sub(/^\/[^\s]+\s?/, '').to_i
    count = 5 if count == 0

    notes = @user.notes.recent.includes(:tags).first(count)
    response_text = "#{ i18n(:caption, count: count) }\n\n"

    notes.each do |note|
      response_text << "\xF0\x9F\x93\x84 "
      response_text << "<strong>#{note.name}</strong>\n" if note.name
      tags_string = note.tags.map{|tag| "##{tag.name}"}.join(' ')
      response_text << "#{tags_string}\n" if tags_string.length > 0

      response_text << "#{note.text}\n"
      response_text << "\n" unless note == notes[-1]
    end

    respond_with(text: response_text.html_safe, parse_mode: 'HTML', disable_web_page_preview: true)
  end
end
