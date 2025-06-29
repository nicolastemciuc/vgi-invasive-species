class PathSightingsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  before_action :load_species_map, only: [ :new, :create ]

  def new
    @path_sighting = PathSighting.new(sighting_date: Date.today)
    @path = params[:path]
  end

  def create
    factory = RGeo::Geographic.spherical_factory(srid: 4326)
    coordinates = JSON.parse(sighting_params[:path])

    points = coordinates.map { |entry| factory.point(entry["lng"], entry["lat"]) }
    line_string = factory.line_string(points)

    @path_sighting = current_user.sightings.build(sighting_params.except(:path))
    @path_sighting.status = "Pendiente"
    @path_sighting.type = "PathSighting"
    @path_sighting.path = line_string

    if @path_sighting.save
      redirect_to sightings_path, notice: "Avistamiento creado exitosamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def sighting_params
    params.expect(path_sighting: [ :location_desc, :description, :sighting_date, :species_id, :photo, :path ])
  end

  def load_species_map
    @species_map = Species.all.map { |s| [ "#{s.common_name} (#{s.scientific_name})", s.id ] }
  end
end
