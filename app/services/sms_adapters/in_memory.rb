module SmsAdapters
  class InMemory
    cattr_accessor :messages
    self.messages = []

    def self.clear_messages
      self.messages = []
    end

    def send_message(args)
      self.class.messages << Message.new(nil, args[:to], args[:text], nil)
    end
  end
end
