RSpec.configure do |config|
  config.before do
    SmsAdapters::InMemory.clear_messages
  end

  config.around do |example|
    # keep old adapter to use after test runs
    old_adapter = SmsClient.adapter

    # set our in-memory adapter
    SmsClient.adapter = SmsAdapters::InMemory

    # run the test
    example.run

    # put back the previous adapter
    SmsClient.adapter = old_adapter
  end
end
