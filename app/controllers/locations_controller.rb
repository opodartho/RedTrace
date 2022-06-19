class LocationsController < ApplicationController
  # GET /locations or /locations.json
  def index
    @locations = Location.all
  end
end
