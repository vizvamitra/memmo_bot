class LastCommand < BaseCommand
  def run
    count = message.text.sub(/^\/[^\s]+\s?/, '').to_i
    count = 5 if count == 0

    notes = @user.notes.recent.first(count)
    response_text = "Last #{count} notes:\n\n"

    notes.map do |note|
      # response_text << "╭#{'╴'*19}\n"

      # response_text << "id: #{note.id}\n"
      # response_text << "<strong>#{note.name}</strong>\n" if note.name
      # tags_string = note.tags.map{|tag| "##{tag.name}"}.join(' ')
      # response_text << "#{tags_string}\n" if tags_string.length > 0

      # response_text << "\n#{note.text}"
      # response_text << "\n╰#{'╴'*19}\n\n"

      response_text << "id: #{note.id}\n"
      response_text << "<strong>#{note.name}</strong>\n" if note.name
      tags_string = note.tags.map{|tag| "##{tag.name}"}.join(' ')
      response_text << "#{tags_string}\n" if tags_string.length > 0

      response_text << "\n#{note.text}"
      response_text << "\n#{'░'*20}\n" unless note == notes[-1]
    end

    respond_with(text: response_text.html_safe, parse_mode: 'HTML', disable_web_page_preview: true)
  end
end
