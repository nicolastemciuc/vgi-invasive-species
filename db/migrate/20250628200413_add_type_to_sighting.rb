class AddTypeToSighting < ActiveRecord::Migration[8.0]
  def change
    add_column :sightings, :type, :string, null: false
  end
end
