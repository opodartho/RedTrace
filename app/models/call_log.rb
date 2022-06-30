class CallLog < ApplicationRecord
  acts_as_tenant :company
  belongs_to :user

  validates :msisdn, :call_type, duration, start_time, end_time, presence: true
end
