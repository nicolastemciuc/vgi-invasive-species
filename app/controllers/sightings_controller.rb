class SightingsController < ApplicationController
  def index
  end

  def new
    @sighting = Sighting.new(
      latitude: params[:lat],
      longitude: params[:lng]
    )
  end
end
