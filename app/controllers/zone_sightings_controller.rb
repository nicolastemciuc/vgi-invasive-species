class ZoneSightingsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  before_action :load_species_map, only: [ :new, :create ]

  def new
    @zone_sighting = ZoneSighting.new(sighting_date: Date.today)
    @zone = params[:zone]
  end

  def create
    factory = RGeo::Geographic.spherical_factory(srid: 4326)
    coordinates = JSON.parse(sighting_params[:zone])

    points = coordinates.map { |entry| factory.point(entry["lng"], entry["lat"]) }
    ring = factory.linear_ring(points)
    polygon = factory.polygon(ring)

    @zone_sighting = current_user.sightings.build(sighting_params.except(:zone))
    @zone_sighting.status = "Pendiente"
    @zone_sighting.type = "ZoneSighting"
    @zone_sighting.zone = polygon

    if @zone_sighting.save
      redirect_to sightings_path, notice: "Avistamiento creado exitosamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def sighting_params
    params.expect(zone_sighting: [ :location_desc, :description, :sighting_date, :species_id, :photo, :zone ])
  end

  def load_species_map
    @species_map = Species.all.map { |s| [ "#{s.common_name} (#{s.scientific_name})", s.id ] }
  end
end
