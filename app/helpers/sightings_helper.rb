module SightingsHelper
  def sightings_json(sightings)
    sightings.map do |s|
      {
        lat: s.latitude,
        lng: s.longitude,
        description: s.description
      }
    end.to_json
  end
end
