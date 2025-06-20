# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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
