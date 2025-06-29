# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

Species.find_or_create_by(scientific_name: "Rattus rattus") do |species|
  species.kingdom = :animalia
  species.phylum = "Chordata"
  species.class_name = "Mammalia"
  species.order = "Rodentia"
  species.family = "Muridae"
  species.genus = "Rattus"
  species.epithet = "rattus"
  species.common_name = "Rata negra"
end

Species.find_or_create_by(scientific_name: "Lantana camara") do |species|
  species.kingdom = :plantae
  species.phylum = "Tracheophyta"
  species.class_name = "Magnoliopsida"
  species.order = "Lamiales"
  species.family = "Verbenaceae"
  species.genus = "Lantana"
  species.epithet = "camara"
  species.common_name = "Lantana"
end

Species.find_or_create_by(scientific_name: "Mytilus galloprovincialis") do |species|
  species.kingdom = :animalia
  species.phylum = "Mollusca"
  species.class_name = "Bivalvia"
  species.order = "Mytilida"
  species.family = "Mytilidae"
  species.genus = "Mytilus"
  species.epithet = "galloprovincialis"
  species.common_name = "Mejillón del Mediterráneo"
end

Species.find_or_create_by(scientific_name: "Parthenium hysterophorus") do |species|
  species.kingdom = :plantae
  species.phylum = "Tracheophyta"
  species.class_name = "Magnoliopsida"
  species.order = "Asterales"
  species.family = "Asteraceae"
  species.genus = "Parthenium"
  species.epithet = "hysterophorus"
  species.common_name = "Hierba de Santa María"
end

Species.find_or_create_by(scientific_name: "Armillaria mellea") do |species|
  species.kingdom = :fungi
  species.phylum = "Basidiomycota"
  species.class_name = "Agaricomycetes"
  species.order = "Agaricales"
  species.family = "Physalacriaceae"
  species.genus = "Armillaria"
  species.epithet = "mellea"
  species.common_name = "Hongo de la miel"
end

# ====== Start seeding for CSV sightings =======

Species.find_or_create_by(scientific_name: "Acacia longifolia") do |species|
  species.kingdom = :plantae
  species.phylum = "Magnoliophyta"
  species.class_name = "Magnoliopsida"
  species.order = "Fabales"
  species.family = "Leguminosae"
  species.genus = "Acacia"
  species.epithet = "longifolia"
  species.common_name = "Acacia"
end

Species.find_or_create_by(scientific_name: "Axis axis") do |species|
  species.kingdom = :animalia
  species.phylum = "Chordata"
  species.class_name = "Mammalia"
  species.order = "Artiodactyla"
  species.family = "Cervidae"
  species.genus = "Axis"
  species.epithet = "axis"
  species.common_name = "Ciervo axis"
end

Species.find_or_create_by(scientific_name: "Eragrostis plana") do |species|
  species.kingdom = :plantae
  species.phylum = "Magnoliophyta"
  species.class_name = "Liliopsida"
  species.order = "Cyperales"
  species.family = "Poaceae"
  species.genus = "Eragrostis"
  species.epithet = "plana"
  species.common_name = "Capin annoni"
end

Species.find_or_create_by(scientific_name: "Gleditsia triacanthos") do |species|
  species.kingdom = :plantae
  species.phylum = "Magnoliophyta"
  species.class_name = "Magnoliopsida"
  species.order = "Fabales"
  species.family = "Leguminosae"
  species.genus = "Gleditsia"
  species.epithet = "triacanthos"
  species.common_name = "Espina de cristo"
end

Species.find_or_create_by(scientific_name: "Ligustrum lucidum") do |species|
  species.kingdom = :plantae
  species.phylum = "Magnoliophyta"
  species.class_name = "Magnoliopsida"
  species.order = "Lamiales"
  species.family = "Oleaceae"
  species.genus = "Ligustrum"
  species.epithet = "lucidum"
  species.common_name = "Ligustro"
end

Species.find_or_create_by(scientific_name: "Lithobates catesbeianus") do |species|
  species.kingdom = :animalia
  species.phylum = "Chordata"
  species.class_name = "Amphibia"
  species.order = "Anura"
  species.family = "Ranidae"
  species.genus = "Lithobates"
  species.epithet = "catesbeianus"
  species.common_name = "Rana toro"
end

Species.find_or_create_by(scientific_name: "Pittosporum undulatum") do |species|
  species.kingdom = :plantae
  species.phylum = "Magnoliophyta"
  species.class_name = "Magnoliopsida"
  species.order = "Apiales"
  species.family = "Pittosporaceae"
  species.genus = "Pittosporum"
  species.epithet = "undulatum"
  species.common_name = " Daphne Australiana"
end

Species.find_or_create_by(scientific_name: "Populus alba") do |species|
  species.kingdom = :plantae
  species.phylum = "Tracheophyta"
  species.class_name = "Magnoliopsida"
  species.order = "Malpighiales"
  species.family = "Salicaceae"
  species.genus = "Populus"
  species.epithet = "albus"
  species.common_name = "álamo blanco"
end

Species.find_or_create_by(scientific_name: "Sus scrofa") do |species|
  species.kingdom = :animalia
  species.phylum = "Chordata"
  species.class_name = "Mammalia"
  species.order = "Artiodactyla"
  species.family = "Suidae"
  species.genus = "Sus"
  species.epithet = "scrofa"
  species.common_name = "Jabalí"
end

Species.find_or_create_by(scientific_name: "Ulex europaeus") do |species|
  species.kingdom = :plantae
  species.phylum = "Magnoliophyta"
  species.class_name = "Magnoliopsida"
  species.order = "Fabales"
  species.family = "Leguminosae"
  species.genus = "Ulex"
  species.epithet = "breoganii"
  species.common_name = "Espinillo"
end

Species.find_or_create_by(scientific_name: "Rubus ulmifolius") do |species|
  species.kingdom = :plantae
  species.phylum = "Magnoliophyta"
  species.class_name = "Magnoliopsida"
  species.order = "Rosales"
  species.family = "Rosaceae"
  species.genus = "Rubus"
  species.epithet = "ulmifolius"
  species.common_name = "Zarzamorak"
end

# ====== Start seeding users =======

User.find_or_create_by!(email: "admin@mail.com") do |user|
  user.password = "password"
  user.role = :admin
end

User.find_or_create_by!(email: "citizen@mail.com") do |user|
  user.password = "password"
  user.role = :citizen
end

User.find_or_create_by!(email: "expert@mail.com") do |user|
  user.password = "password"
  user.role = :expert
end

User.find_or_create_by!(email: "ideuy@mail.com") do |user|
  user.password = "password"
  user.role = :expert
end

# ====== Start seeding sightings =======

def parse_event_date(value)
  return Time.current if value.blank? || value.strip.upcase == 'NA'

  begin
    # Try dd/mm/yyyy
    if value =~ %r{\A(\d{1,2})/(\d{1,2})/(\d{4})\z}
      day, month, year = value.split('/').map(&:to_i)
      Date.new(year, month, day)
    # Try yyyy only
    elsif value =~ /\A\d{4}\z/
      Date.new(value.to_i)
    else
      Time.current
    end
  rescue ArgumentError
    Time.current
  end
end


def load_csv_to_user(file_path, userId)
  puts "Processing #{file_path}..."

  rows = CSV.read(file_path, headers: true)

  scientific_name = rows[0]["scientific(scientific)"] ||
    rows[0]["especie(especie)"] ||
    rows[0]["nombre(nombre)"] ||
    rows[0]["nombre_cie(nombre_cie)"]


  specie = Species.find_by(scientific_name: scientific_name)


  if specie == nil
    puts("=========== SPECIES IS NIL =========")
    puts(specie)
    puts(scientific_name)
    puts("=========== SPECIES IS NIL =========")
    return
  end

  data = rows.map do |row|
    lat = row['decimallat(decimallat)'] || row["latitud(latitud)"]
    lon = row['decimallon(decimallon)'] || row["longitud(longitud)"]

    event_date = parse_event_date(row['eventdate(eventdate)'] || row["fecha(fecha)"] || row["fecha_regi(fecha_regi)"])

    # Skip invalid lat/lon
    next if lat.blank? || lon.blank?

    {
      description: nil,
      location_description: row["stateprovi(stateprovi)"] || row["localidad(localidad)"],
      path: nil,
      point: "SRID=4326;POINT(#{lon} #{lat})",
      sighting_date: event_date,
      status: 'Confirmado',
      type: 'PointSighting',
      validated_at: event_date,
      zone: nil,
      created_at: Time.current,
      updated_at: Time.current,
      species_id: specie.id,
      submitted_by_id: userId,
      validated_by_id: userId
    }
  end.compact # Remove `nil` entries (from invalid rows)

  data.uniq! { |row| [ row[:species_id], row[:submitted_by_id], row[:point] ] }

  Sighting.upsert_all(data, unique_by: :index_sightings_on_species_user_point) if data.any?
  puts "Finished #{file_path} ✅"
end

user = User.find_by(email: "ideuy@mail.com")
csv_files = Dir[Rails.root.join("db/csv/*.csv")]

threads = csv_files.map do |file_path|
  Thread.new { load_csv_to_user(file_path, user.id) }
end

threads.each(&:join)
