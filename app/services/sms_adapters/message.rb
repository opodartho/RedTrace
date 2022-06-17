module SmsAdapters
  Message = Struct.new(:id, :to, :text, :sent_at)
end
