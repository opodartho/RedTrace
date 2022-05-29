class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable, :rememberable

  has_many :locations, dependent: :destroy

  # the authenticate method from devise documentation
  def self.authenticate(msisdn, password)
    user = User.find_for_authentication(msisdn: msisdn)
    user&.valid_password?(password) ? user : nil
  end
end
