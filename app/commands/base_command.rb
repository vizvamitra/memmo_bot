class BaseCommand
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
end