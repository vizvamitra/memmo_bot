class BaseCommand
  class Response
    attr_reader :method, :text, :chat_id, :parse_mode,
                :disable_web_page_preview, :disable_notification,
                :reply_to_message_id, :reply_markup

    def initialize(opts)
      @method ='sendMessage'
      @text = opts.fetch(:text)
      @chat_id = opts.fetch(:chat_id)

      @parse_mode = opts.fetch(:parse_mode, nil)
      @disable_web_page_preview = opts.fetch(:disable_web_page_preview, false)
      @disable_notification = opts.fetch(:disable_notification, false)
      @reply_to_message_id = opts.fetch(:reply_to_message_id, nil)
      @reply_markup = opts.fetch(:reply_markup, nil)

      validate
    end

    def to_h
      {
        method: method,
        text: text,
        chat_id: chat_id,
        parse_mode: parse_mode,
        disable_web_page_preview: disable_web_page_preview,
        disable_notification: disable_notification,
        reply_to_message_id: reply_to_message_id,
        reply_markup: reply_markup
     }.reject{|_,v| v.nil?}
    end

    private

    def validate
      allowed_parse_modes = ['Markdown', 'HTML']
      if parse_mode && !allowed_parse_modes.include?(parse_mode)
        raise ArgumentError, "Unexpected value of parse_mode: #{parse_mode}. Allowed values: #{allowed_parse_modes}."
      end

      if reply_to_message_id && !reply_to_message_id.is_a?(Fixnum)
        raise ArgumentError, "Unexpected value of reply_to_message_id: #{reply_to_message_id}. Fixnum expected."
      end
    end
  end
end