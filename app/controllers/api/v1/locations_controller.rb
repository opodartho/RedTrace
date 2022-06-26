module Api
  module V1
    class LocationsController < ApplicationController
      def index
        @locations = current_user.locations
        render json: { locations: @locations }
      end

      def create
        location = Location.new(location_params.merge(user: current_user))

        if location.save
          render json: { location: location }, status: :created
        else
          render json: location.errors, status: :unprocessable_entity
        end
      end

      private
      # Only allow a list of trusted parameters through.
      def location_params
        params.require(:location).permit(:longitude, :latitude, :tracked_at)
      end
    end
  end
end
