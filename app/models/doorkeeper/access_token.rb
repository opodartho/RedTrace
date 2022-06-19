module Doorkeeper
  class AccessToken < ::ActiveRecord::Base
    acts_as_tenant :company
  end
end
