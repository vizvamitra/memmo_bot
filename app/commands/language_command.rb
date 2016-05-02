class LanguageCommand < BaseCommand
  include Rails.application.routes.url_helpers

  KNOWN_LANGUAGES = {
    'English' => 'en',
    'Русский' => 'ru'
  }

  def run
    user.regenerate_callback_token

    respond_with({
      text: i18n(:select_language),
      reply_markup: {
        inline_keyboard: build_inline_keyboard
      }
    })
  end

  private

  def build_inline_keyboard
    KNOWN_LANGUAGES.map do |label, language|
      [{
        text: label,
        url: language_callback_url(token: user.callback_token, language: language)
      }]
    end
  end
end
