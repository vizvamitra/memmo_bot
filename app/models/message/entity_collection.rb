class Message
  class EntityCollection < Array
    def hashtags
      self.select{|entity| entity.type == 'hashtag'}
    end
  end
end