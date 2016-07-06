class BaseCommand
  include ActionView::Helpers::TextHelper

  MAX_TEXT_LENGTH = 200

  attr_reader :response

  def initialize(user, message)
    @user = user
    @message = message
  end

  def run
    raise NotImplementedError
  end

  private

  attr_reader :user, :message

  def respond_with(opts)
    opts.merge!(chat_id: message.chat.id)
    @response = Response.new(opts).to_h
  end

  def command_name
    self.class.name.underscore.sub(/_command$/, '')
  end

  def i18n(key, args={})
    args.merge!(locale: user.language)
    I18n.t( "commands.#{command_name}.#{key}", args )
  end

  def text_too_long?(text)
    text.length > MAX_TEXT_LENGTH
  end

  def truncated(text)
    truncate(text, length: MAX_TEXT_LENGTH, separator: ' ')
  end
end