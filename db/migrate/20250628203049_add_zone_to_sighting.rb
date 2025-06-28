class AddZoneToSighting < ActiveRecord::Migration[8.0]
  def change
    add_column :sightings, :zone, :st_polygon, geographic: true
  end
end
