class ChangeLanguageCallback < BaseCallback
  def run
    if user.update(language: language)
      response_text = i18n(:success, language: language_label)
    else
      response_text = i18n(:failure)
    end

    respond_with(text: response_text)
  end

  private

  def language
    query.data.params.language
  end

  def language_label
    label = I18n.t("languages.#{language}")
  end
end