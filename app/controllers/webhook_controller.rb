class WebhookController < ApplicationController
  before_action :validate_token

  def create
    command.run
    render json: command.response
  end

  def debug
    respond_with_message_content
  end

  private

  def validate_token
    head 403 if params[:token] != Rails.application.secrets.webhook_token
  end

  def message
    @message ||= begin
      raw_message = JSON.parse(request.body.read)['message']
      Message.new(raw_message)
    end
  end

  def user
    @user ||= User.find_or_create_by(telegram_id: message.from.id)
  end

  def command
    @command ||= begin
      command = message.entities.find{|e| e.type == 'bot_command'}
      command_name = command ? command.body : 'add'
      command_class = "#{command_name.classify}Command".constantize
      command_class.new(user, message)
    end
  end

  # temporary
  def respond_with_message_content
    raw_message = JSON.parse(request.body.read)
    chat_id = raw_message['message']['chat']['id']

    message = "```\n#{JSON.pretty_generate(raw_message)}\n```"
    response = {method: 'sendMessage', text: message, chat_id: chat_id, parse_mode: 'Markdown'}

    render json: response
  end
end