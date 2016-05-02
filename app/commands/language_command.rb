class LanguageCommand < BaseCommand
  LANGUAGES = {
    'English' => 'en',
    'Русский' => 'ru'
  }

  def run
    respond_with({
      text: i18n(:select_language),
      reply_markup: {inline_keyboard: build_inline_keyboard}
    })
  end

  private

  def build_inline_keyboard
    LANGUAGES.
      map{|label, lang| {text: label, callback_data: lang} }.
      in_groups(2)
  end
end
