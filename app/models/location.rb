class Location < ApplicationRecord
  acts_as_tenant :company
  belongs_to :user

  validates :longitude, :latitude, :tracked_at, presence: true
end
