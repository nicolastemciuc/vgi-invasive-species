class CreateSpecies < ActiveRecord::Migration[8.0]
  def change
    create_table :species do |t|
      t.integer :kingdom, null: false
      t.string :phylum
      t.string :class_name
      t.string :order
      t.string :family
      t.string :genus, null: false
      t.string :epithet, null: false
      t.string :scientific_name, null: false
      t.string :common_name

      t.timestamps
    end
    add_index :species, :scientific_name, unique: true
  end
end
