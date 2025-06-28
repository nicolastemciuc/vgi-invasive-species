class RemoveCoordenatesFromSighting < ActiveRecord::Migration[8.0]
  def change
    remove_column :sightings, :latitude, :decimal
    remove_column :sightings, :longitude, :decimal
  end
end
