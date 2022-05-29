module Api
  module V1
    class LocationsController < ApplicationController
      def index
        @locations = current_user.locations
        render json: { locations: @locations }
      end
    end
  end
end
