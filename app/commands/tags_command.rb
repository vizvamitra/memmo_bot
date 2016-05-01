class TagsCommand < BaseCommand
  def run
    response_text = "Existing tags:\n\n"
    grouped_tags = user.tags.order(:name).group_by{|tag| tag.name[0]}

    grouped_tags.each do |first_letter, tags|
      response_text << "<strong>#{first_letter.upcase}</strong>\n"
      response_text << tags.sort_by(&:name).map{|t| "##{t.name}"}.join(' ')

      response_text << "\n\n" unless first_letter == grouped_tags.keys[-1]
    end

    respond_with({text: response_text, parse_mode: 'HTML', disable_web_page_preview: true})
  end
end