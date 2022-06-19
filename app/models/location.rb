class Location < ApplicationRecord
  acts_as_tenant :company
  belongs_to :user

  validates :longitude, :latitude, presence: true
end
