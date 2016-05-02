class CommandDispatcher < BaseDispatcher
  UnknownCommandError = Class.new(DispatchError)

  def initialize(raw_message)
    @message = Message.new(raw_message)
  end

  def dispatch
    command.run
    command.response
  end

  private

  attr_reader :message

  def user
    @user ||= User.find_or_create_by(telegram_id: message.from.id)
  end

  def command
    @command ||= begin
      command_class = "#{command_name}Command".constantize
      command_class.new(user, message)
    end
  rescue NameError => e
    raise UnknownCommandError, "Unknown command: #{message.to_json}"
  end

  def command_name
    command_entity = message.entities.find{|e| e.type == 'bot_command'}
    name = (command_entity ? command_entity.body : 'add')
    name.camelize.tap{|n| n[0].upcase!}
  end
end