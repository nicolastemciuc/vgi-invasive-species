class SightingsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  before_action :load_species_map, only: [ :new, :create ]

  def index
    @sightings = Sighting.all
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
    params.expect(sighting: [ :latitude, :longitude, :location_desc, :description, :sighting_date, :species_id, :photo ])
  end

  def load_species_map
    @species_map = Species.all.map { |s| [ "#{s.common_name} (#{s.scientific_name})", s.id ] }
  end
end
