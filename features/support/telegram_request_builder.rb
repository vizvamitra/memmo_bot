class TelegramRequestBuilder

  def initialize(opts)
    @message = opts.fetch(:message)
    @user = opts.fetch(:user)
    @entities = []
    parse_message
  end

  def build
    {
      "update_id": 324458991,
      "message": {
        "message_id": 787,
        "from": {
          "id": user.telegram_id,
          "first_name": "test",
          "username": "test"
        },
        "chat": {
          "id": user.telegram_id,
          "first_name": "test",
          "username": "test",
          "type": "private"
        },
        "date": 1463657767,
        "text": message,
        "entities": entities
      }
    }
  end

  private

  attr_reader :user, :message, :entities

  def parse_message
    command_match = @message.match(/^\/[^\s]+/)
    if command_match[0]
      entities << entity('bot_command', command_match.offset(0))
    end

    tags_match = @message.to_enum(:scan, /#[^\s]+/).map{Regexp.last_match}
    tags_match.each do |match|
      entities << entity('hashtag', match.offset(0))
    end
  end

  def entity(type, offset)
    {
      "type": type,
      "offset": offset[0],
      "length": offset[1] - offset[0]
    }
  end

end