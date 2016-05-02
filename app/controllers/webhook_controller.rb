class WebhookController < ApplicationController
  before_action :validate_token

  def create
    event = JSON.parse(request.body.read)
    result = EventDispatcher.new(event).dispatch
    render json: result
  rescue BaseDispatcher::DispatchError => e
    logger.warn(e.message)
    head 200 # we don't want telegram to retry unknown events
  end

  def debug
    respond_with_message_content
  end

  private

  def validate_token
    head 403 if params[:token] != Rails.application.secrets.webhook_token
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