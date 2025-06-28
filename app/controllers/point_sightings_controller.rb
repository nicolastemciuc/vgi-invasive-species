class PointSightingsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  before_action :load_species_map, only: [ :new, :create ]

  def show
    @point_sighting = Sighting.find(params[:id])

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
    @point_sighting = PointSighting.new

    @latitude = params[:lat]
    @longitude = params[:lng]
  end

  def create
    factory = RGeo::Geographic.spherical_factory(srid: 4326)

    @point_sighting = current_user.sightings.build(sighting_params.except(:latitude, :longitude))
    @point_sighting.status = "Pendiente"
    @point_sighting.type = "PointSighting"
    @point_sighting.point = factory.point(sighting_params[:longitude], sighting_params[:latitude])

    if @point_sighting.save
      redirect_to sightings_path, notice: "Avistamiento creado exitosamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @point_sighting = Sighting.find(params[:id])
    if @point_sighting.update(update_params)
      redirect_to @point_sighting, notice: "Avistamiento actualizado con éxito."
    else
      redirect_to @point_sighting, alert: "Error al actualizar"
    end
  end

  private

  def sighting_params
    params.expect(point_sighting: [:location_desc, :description, :sighting_date, :species_id, :photo, :latitude, :longitude ])
  end

  def update_params
    params.expect(point_sighting: [ :status ])
  end

  def load_species_map
    @species_map = Species.all.map { |s| [ "#{s.common_name} (#{s.scientific_name})", s.id ] }
  end
end
