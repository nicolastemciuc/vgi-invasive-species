class ZoneSightingsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_species_map

  def new
    @sighting = ZoneSighting.new(sighting_date: Date.today)
    @geometry = params[:zone]

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def create
    factory = RGeo::Geographic.spherical_factory(srid: 4326)
    coordinates = JSON.parse(sighting_params[:geometry])

    points = coordinates.map { |entry| factory.point(entry["lng"], entry["lat"]) }
    ring = factory.linear_ring(points)
    polygon = factory.polygon(ring)

    @sighting = current_user.sightings.build(sighting_params.except(:geometry))
    @sighting.status = "Pendiente"
    @sighting.type = "ZoneSighting"
    @sighting.zone = polygon

    if @sighting.save
      redirect_to sightings_path, notice: "Avistamiento creado exitosamente"
    else
      format.turbo_stream { render :new, status: :unprocessable_entity }
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  private

  def sighting_params
    params.expect(zone_sighting: [ :location_desc, :description, :sighting_date, :species_id, :photo, :geometry ])
  end
end
