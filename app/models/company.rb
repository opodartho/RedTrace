class Company < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true
  validates :subdomain, format: {
    with: /\A(^[A-Za-z0-9](?:[A-Za-z0-9\-]{0,61}[A-Za-z0-9])?$)\z/i,
    message: 'must be a valid subdomain',
    if: -> { subdomain? },
  }
end
