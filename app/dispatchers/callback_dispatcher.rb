class CallbackDispatcher < BaseDispatcher
  UnknownCallbackError = Class.new(DispatchError)

  def initialize(raw_query)
    @query = CallbackQuery.new(raw_query)
  end

  def dispatch
    callback.run
    callback.response
  end

  private

  attr_reader :query

  def user
    @user ||= User.find_by(telegram_id: query.from.id)
  end

  def callback
    @callback ||= begin
      callback_class = "#{callback_name}Callback".constantize
      callback_class.new(user, query)
    end
  rescue NameError => e
    raise UnknownCallbackError, "Unknown callback: #{query.to_json}"
  end

  def callback_name
    query.data.method.camelize.tap{|n| n[0].upcase!}
  end
end