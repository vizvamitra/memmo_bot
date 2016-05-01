class TagsCommand < BaseCommand
  def run
    all_tags = user.tags.select('distinct(tags.name)').order(:name)
    grouped_tags = all_tags.group_by{|tag| tag.name[0]}

    response_text = "#{i18n(:caption)}\n\n"

    grouped_tags.each do |first_letter, tags|
      response_text << "<strong>#{first_letter.upcase}</strong>\n"
      response_text << tags.sort_by(&:name).map{|t| "##{t.name}"}.join(' ')

      response_text << "\n\n" unless first_letter == grouped_tags.keys[-1]
    end

    respond_with({text: response_text, parse_mode: 'HTML', disable_web_page_preview: true})
  end
end