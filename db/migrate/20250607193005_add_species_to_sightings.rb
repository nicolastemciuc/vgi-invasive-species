class AddSpeciesToSightings < ActiveRecord::Migration[8.0]
  def change
    add_column :sightings, :species_id, :integer
  end
end
