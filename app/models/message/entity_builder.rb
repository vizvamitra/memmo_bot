# Extracts entities from telegram message text

class Message::EntityBuilder
  EXTRACT_TYPES = %w(bot_command hashtag url)

  def initialize(text, raw_entity)
    @text = text
    @raw_entity = raw_entity
  end

  def build
    OpenStruct.new(raw_entity).tap do |entity|
      entity.body = extract_body(entity) if should_extract_body?(entity)
    end
  end

  private

  attr_reader :text, :raw_entity

  def should_extract_body?(entity)
    EXTRACT_TYPES.include?(entity.type)
  end

  def extract_body(entity)
    body = text[entity.offset, entity.length]

    case entity.type
    when 'bot_command' then body.sub(/^\//, '').sub(/__.+/, '')
    when 'hashtag' then body.sub(/^#/, '')
    else body
    end
  end
end