class LastCommand < BaseCommand
  def run
    count = message.text.sub(/^\/[^\s]+\s?/, '').to_i

    notes = @user.notes.recent.first(count)
    response_text = ""

    notes.map do |note|
      response_text << "<b>#{note.name}</b>\n" if note.name

      tags_string = note.tags.map{|tag| "##{tag.name}"}.join(' ')
      response_text << "#{tags_string}\n" if tags_string.length > 0
      response_text << note.text
      response_text << "\n-----------------------\n" unless note == notes[-1]
    end

    respond_with(text: response_text.html_safe, parse_mode: 'HTML')
  end

  private

  def replace_html(text)
    text.gsub('<', '&lt;').gsub('>', '&gt;').gsub('&', '&amp;')
  end
end
