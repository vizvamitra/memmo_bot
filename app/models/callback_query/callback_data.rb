class CallbackQuery
  class CallbackData
    attr_reader :method, :params

    def initialize(raw_data)
      raw_data = Marshal.load(raw_data)

      @method = raw_data.fetch(:m)
      @params = OpenStruct.new( raw_data.fetch(:p) )
    end
  end
end