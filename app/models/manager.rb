class Manager < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :lockable, :timeoutable, :trackable

  class << self
    def authentication_keys
      [:username]
    end
  end
end
