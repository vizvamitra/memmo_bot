class Callbacks::LanguageController < ApplicationController
  before_action :validate_token

  def update
    user.regenerate_callback_token

    user.language = params[:language]
    head(user.save ? 200 : 422)
  end

  def validate_token
    head 403 if params[:token] != user.callback_token
  end

  def query
    @query ||= begin
      raw_query = JSON.parse(request.body.read)
      CallbackQuery.new(raw_query)
    end
  end

  def user
    @user ||= User.find_or_create_by(telegram_id: query.from.id)
  end
end
