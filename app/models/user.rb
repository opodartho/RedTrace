class User < ApplicationRecord
  acts_as_tenant :company
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable, :rememberable, :recoverable

  has_many :locations, dependent: :destroy
  has_many :call_logs, dependent: :destroy

  before_create :set_otp_confirmation_token

  validates :name, :msisdn, presence: true

  validates_uniqueness_to_tenant :msisdn

  validates :msisdn, format: {
    with: /\A(8801[3-9]\d{8})\z/i,
    message: 'must be a valid msisdn',
    if: -> { msisdn? },
  }

  # the authenticate method from devise documentation
  def self.authenticate(msisdn, password)
    user = User.find_for_authentication(msisdn:)
    user&.valid_password?(password) ? user : nil
  end

  def otp_confirmation_token
    ROTP::Base32.encode(
      Digest::MD5.hexdigest(
        "#{Devise.secret_key}#{self[:msisdn]}#{self[:otp_confirmation_token]}_otp_verification#{self[:created_at]}",
      ),
    )
  end

  private

  def set_otp_confirmation_token
    self.otp_confirmation_token = ROTP::Base32.random
  end
end
