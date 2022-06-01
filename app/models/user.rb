class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable, :rememberable, :recoverable

  has_many :locations, dependent: :destroy

  attr_accessor :otp, :email

  before_create :set_otp_confirmation_token

  # the authenticate method from devise documentation
  def self.authenticate(msisdn, password)
    user = User.find_for_authentication(msisdn: msisdn)
    user&.valid_password?(password) ? user : nil
  end

  def otp_confirmation_token
    ROTP::Base32.encode(
      Digest::MD5.hexdigest(
        Devise.secret_key + self[:msisdn] + self[:otp_confirmation_token] + '_otp_verification' + self[:created_at].to_s
      )
    )
  end

  private

  def set_otp_confirmation_token
    self.otp_confirmation_token = ROTP::Base32.random
  end
end
