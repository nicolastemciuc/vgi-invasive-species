class PointSightingsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_species_map

  def new
    @sighting = PointSighting.new(sighting_date: Date.today)
    @geometry = params[:point]

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def create
    factory = RGeo::Geographic.spherical_factory(srid: 4326)
    coordinates = JSON.parse(sighting_params[:geometry])

    @sighting = current_user.sightings.build(sighting_params.except(:geometry))
    @sighting.status = "Pendiente"
    @sighting.type = "PointSighting"
    @sighting.point = factory.point(coordinates["lng"], coordinates["lat"])

    if @sighting.save
      redirect_to sightings_path, notice: "Avistamiento creado exitosamente"
    else
      format.turbo_stream { render :new, status: :unprocessable_entity }
      format.html { render :new, status: :unprocessable_entity }
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
    params.expect(point_sighting: [ :location_desc, :description, :sighting_date, :species_id, :photo, :geometry ])
  end

  def update_params
    params.expect(point_sighting: [ :status ])
  end
end
