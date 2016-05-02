class EventDispatcher < BaseDispatcher
  UnknownEventError = Class.new(DispatchError)

  def initialize(event)
    @event = event
  end

  def dispatch
    if message?
      CommandDispatcher.new(event['message']).dispatch
    elsif callback_query?
      CallbackDispatcher.new(event['callback_query']).dispatch
    else
      raise UnknownEventError, "Unknown event: #{event.to_json}"
    end
  end

  private

  attr_reader :event

  def message?
    event['message'].present?
  end

  def callback_query?
    event['callback_query'].present?
  end
end