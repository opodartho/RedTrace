module SmsAdapters
  class Local
    def self.messages
      Dir[Rails.root.join('storage', '**', '*.msg')].map do |filename|
        splited = filename.split(%r{(/|\.|-)})
        Message.new(
          "#{splited[-5]}-#{splited[-3]}",
          splited[-5],
          File.read(filename),
          Time.zone.at(splited[-3].to_i),
        )
      end.sort_by(&:sent_at).reverse
    end

    def self.clear_messages(id = 'all')
      if id.eql?('all')
        ActiveStorage::Blob.service.delete_prefixed('smses')
      else
        ActiveStorage::Blob.service.delete("smses/#{id}.msg")
      end
    end

    def send_message(args)
      msisdn = args[:to]
      message = args[:text]

      file = Tempfile.new('sms')
      file.write message
      file.rewind
      ActiveStorage::Blob.service.upload("smses/#{msisdn}-#{Time.now.utc.to_i}.msg", file.path)
      file.close
      file.unlink
    end
  end
end
