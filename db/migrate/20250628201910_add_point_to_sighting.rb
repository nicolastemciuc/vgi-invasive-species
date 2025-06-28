class AddPointToSighting < ActiveRecord::Migration[8.0]
  def change
    add_column :sightings, :point, :st_point, geographic: true
  end
end
