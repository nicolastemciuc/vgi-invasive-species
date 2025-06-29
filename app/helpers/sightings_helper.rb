module SightingsHelper
  def point_sightings_json(sightings)
    sightings.map do |s|
      {
        lat: s.point&.latitude,
        lng: s.point&.longitude,
        description: s.description,
        url: sighting_path(s),
        type: s.type
      }
    end.to_json
  end

  def path_sightings_json(sightings)
    sightings.map do |s|
      {
        url: sighting_path(s),
        type: s.type,
        path: parse_path(s.path)
      }
    end.to_json
  end

  def zone_sightings_json(sightings)
    sightings.map do |s|
      {
        url: sighting_path(s),
        type: s.type,
        zone: parse_zone(s.zone),
        description: s.description
      }
    end.to_json
  end

  private

  def parse_path(path)
    path.points.map do |point|
    {
      lat: point.latitude,
      lng: point.longitude
    }
    end
  end

  def parse_zone(zone)
    zone = RGeo::GeoJSON.encode(zone)["coordinates"][0]

    zone.map do |point|
      {
        lat: point[1],
        lng: point[0]
      }
    end
  end
end
