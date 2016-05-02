class CallbackQuery
  attr_reader :id, :from, :message, :inline_message_id, :data

  def initialize(raw_query)
    @id = raw_query.fetch('id')
    @inline_message_id = raw_query.fetch('inline_message_id', nil)

    @from = OpenStruct.new( raw_query.fetch('from') )
    @message = Message.new( raw_query.fetch('message') )
    @data = CallbackData.new( raw_query.fetch('data') )
  end
end
