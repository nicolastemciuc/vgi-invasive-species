# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_05_014946) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "postgis"

  create_table "species", force: :cascade do |t|
    t.integer "kingdom", null: false
    t.string "phylum"
    t.string "class_name"
    t.string "order"
    t.string "family"
    t.string "genus", null: false
    t.string "epithet", null: false
    t.string "scientific_name", null: false
    t.string "common_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scientific_name"], name: "index_species_on_scientific_name", unique: true
  end

  create_table "sightings", force: :cascade do |t|
    t.decimal "latitude", precision: 9, scale: 6
    t.decimal "longitude", precision: 9, scale: 6
    t.bigint "submitted_by_id", null: false
    t.text "location_description"
    t.text "description"
    t.string "status"
    t.date "sighting_date"
    t.bigint "validated_by_id"
    t.datetime "validated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["submitted_by_id"], name: "index_sightings_on_submitted_by_id"
    t.index ["validated_by_id"], name: "index_sightings_on_validated_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "sightings", "users", column: "submitted_by_id"
  add_foreign_key "sightings", "users", column: "validated_by_id"
end
