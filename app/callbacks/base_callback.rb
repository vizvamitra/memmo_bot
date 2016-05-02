class BaseCallback
  attr_reader :response

  def initialize(user, query)
    @user = user
    @query = query
  end

  def run
    raise NotImplementedError
  end

  private

  attr_reader :user, :query

  def respond_with(opts)
    opts.merge!(chat_id: query.message.chat.id)
    @response = Response.new(opts).to_h
  end

  def command_name
    self.class.name.underscore.sub(/_callback$/, '')
  end

  def i18n(key, args={})
    args.merge!(locale: user.language)
    I18n.t( "callbacks.#{command_name}.#{key}", args )
  end
end