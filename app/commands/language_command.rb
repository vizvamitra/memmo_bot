class LanguageCommand < BaseCommand
  def run
    respond_with({
      text: i18n(:select_language),
      reply_markup: {inline_keyboard: build_inline_keyboard}
    })
  end

  private

  def build_inline_keyboard
    SUPPORTED_LANGUAGES.map do |lang|
      label = I18n.t("languages.#{lang}")
      {
        text: label,
        callback_data: Marshal.dump(
          m: "change_language",
          p: { language: lang }
        )
      }
    end.in_groups(2)
  end
end
