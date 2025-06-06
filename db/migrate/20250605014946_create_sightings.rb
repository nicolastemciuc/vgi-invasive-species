class CreateSightings < ActiveRecord::Migration[8.0]
  def change
    create_table :sightings do |t|
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6
      t.references :submitted_by, null: false, foreign_key: { to_table: :users }
      t.text :location_description
      t.text :description
      t.string :status
      t.date :sighting_date
      t.references :validated_by, foreign_key: { to_table: :users }
      t.datetime :validated_at

      t.timestamps
    end
  end
end
