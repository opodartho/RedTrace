class SmsClient
  cattr_accessor :adapter
  self.adapter = SmsAdapters::SingleApp

  def initialize
    @client = adapter.new
  end

  def send_message(args)
    @client.send_message(args)
  end
end
