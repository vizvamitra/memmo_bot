class Message
  attr_reader :id, :date, :text, :from, :chat, :entities

  def initialize(raw_message)
    @id = raw_message.fetch('message_id')
    @date = Time.zone.at( raw_message.fetch('date') ).to_datetime
    @text = raw_message.fetch('text')

    @from = OpenStruct.new( raw_message.fetch('from') )
    @chat = OpenStruct.new( raw_message.fetch('chat') )
    @entities = build_entities( raw_message.fetch('entities', []) )
  end

  private

  def build_entities(raw_entities)
    entities_array = raw_entities.map do |raw_entity|
      EntityBuilder.new(text, raw_entity).build
    end
    EntityCollection.new(entities_array)
  end
end
