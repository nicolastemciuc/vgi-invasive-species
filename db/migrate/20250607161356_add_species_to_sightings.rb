class AddSpeciesToSightings < ActiveRecord::Migration[8.0]
  def change
    add_column :sightings, :species_id, :string
    add_column :sightings, :int, :string
  end
end
