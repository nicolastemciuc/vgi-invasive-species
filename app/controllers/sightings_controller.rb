class SightingsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  def index
  end

  def new
    @sighting = Sighting.new(
      latitude: params[:lat],
      longitude: params[:lng]
    )
  end

  def create
    @sighting = current_user.sightings.build(sighting_params)
    @sighting.status = "Pendiente"

    if @sighting.save
      redirect_to sightings_path, notice: "Avistamiento creado exitosamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def sighting_params
    params.expect(sighting: [ :latitude, :longitude, :location_desc, :description, :sighting_date ])
  end
end
