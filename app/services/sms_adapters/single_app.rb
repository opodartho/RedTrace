module SmsAdapters
  class SingleApp
    REQUEST_PATH = '/api/v2/sms/send'.freeze

    attr_reader :conn

    def initialize
      @conn = Faraday.new(
        url: SA_BASE_URL,
        headers: { 'Content-Type' => 'application/json' },
      )
    end

    def send_message(args)
      conn.post(REQUEST_PATH) do |req|
        req.body = { gift_to: args[:to], msg: ROTP::Base32.encode(args[:text]) }.to_json
      end
    end
  end
end
