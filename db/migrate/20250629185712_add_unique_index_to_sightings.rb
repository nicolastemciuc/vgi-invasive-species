class AddUniqueIndexToSightings < ActiveRecord::Migration[8.0]
  def change
    add_index :sightings,
      "species_id, submitted_by_id, ST_AsText(point)",
      unique: true,
      name: "index_sightings_on_species_user_point"
  end
end

