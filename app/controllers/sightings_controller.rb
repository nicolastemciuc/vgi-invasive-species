class SightingsController < ApplicationController
  def index
    @point_sightings = current_user&.expert? || current_user&.admin? ? PointSighting.all : PointSighting.confirmed
    @path_sightings = current_user&.expert? || current_user&.admin? ? PathSighting.all : PathSighting.confirmed
    @zone_sightings = current_user&.expert? || current_user&.admin? ? ZoneSighting.all : ZoneSighting.confirmed
  end

  def show
    @sighting = Sighting.find(params[:id])

    respond_to do |format|
      format.html do
        if turbo_frame_request?
          render partial: "sightings/sighting_frame", locals: { sighting: @sighting }
        else
          redirect_to root_path, notice: "No se encontró el avistamiento"
        end
      end
    end
  end
end
