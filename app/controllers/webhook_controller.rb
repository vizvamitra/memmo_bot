class WebhookController < ApplicationController
  before_action :validate_token

  def create
    message = JSON.parse(request.body.read)['message']
    chat_id = message['chat']['id']
    text = message['text']

    message = "```\n#{JSON.pretty_generate(message)}\n```"
    response = {method: 'sendMessage', text: message, chat_id: chat_id, parse_mode: 'Markdown'}

    render json: response
  end

  private

  def validate_token
    head 403 if params[:token] != Rails.application.secrets.webhook_token
  end
end
