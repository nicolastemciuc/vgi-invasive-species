class SightingsController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :load_species_map, only: :new

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

  def new
    sighting_date = Date.today
    @sighting = nil

    if params[:lat].present? && params[:lng].present?
      @sighting = PointSighting.new(sighting_date:)
      @latitude = params[:lat]
      @longitude = params[:lng]
    elsif params[:zone].present?
      @sighting = ZoneSighting.new(sighting_date:)
      @zone = params[:zone]
    elsif params[:path].present?
      @sighting = PathSighting.new(sighting_date:)
      @path = params[:path]
    end
  end
end
