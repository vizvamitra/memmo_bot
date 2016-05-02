class CallbackQuery
  attr_reader :id, :from, :message, :inline_message_id, :data

  def initialize(raw_query)
    @id = raw_message.fetch('id')
    @inline_message_id = raw_query.fetch('inline_message_id')
    @data = raw_message.fetch('data')

    @from = OpenStruct.new( raw_query.fetch('from') )
    @message = Message.new( raw_query.fetch('message') )
  end
end
