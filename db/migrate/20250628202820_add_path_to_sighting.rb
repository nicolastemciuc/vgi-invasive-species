class AddPathToSighting < ActiveRecord::Migration[8.0]
  def change
    add_column :sightings, :path, :line_string, geographic: true
  end
end
