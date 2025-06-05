# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Species.find_or_create_by(scientific_name: "Homo sapiens") do |species|
  species.kingdom = :animalia
  species.phylum = "Chordata"
  species.class_name = "Mammalia"
  species.order = "Primates"
  species.family = "Hominidae"
  species.genus = "Homo"
  species.epithet = "sapiens"
  species.common_name = "Human"
end

Species.find_or_create_by(scientific_name: "Canis lupus") do |species|
  species.kingdom = :animalia
  species.phylum = "Chordata"
  species.class_name = "Mammalia"
  species.order = "Carnivora"
  species.family = "Canidae"
  species.genus = "Canis"
  species.epithet = "lupus"
  species.common_name = "Gray wolf"
end

Species.find_or_create_by(scientific_name: "Rosa canina") do |species|
  species.kingdom = :plantae
  species.phylum = "Magnoliophyta"
  species.class_name = "Magnoliopsida"
  species.order = "Rosales"
  species.family = "Rosaceae"
  species.genus = "Rosa"
  species.epithet = "canina"
  species.common_name = "Dog rose"
end

Species.find_or_create_by(scientific_name: "Agaricus bisporus") do |species|
  species.kingdom = :fungi
  species.phylum = "Basidiomycota"
  species.class_name = "Agaricomycetes"
  species.order = "Agaricales"
  species.family = "Agaricaceae"
  species.genus = "Agaricus"
  species.epithet = "bisporus"
  species.common_name = "White mushroom"
end

Species.find_or_create_by(scientific_name: "Escherichia coli") do |species|
  species.kingdom = :bacteria
  species.phylum = "Proteobacteria"
  species.class_name = "Gammaproteobacteria"
  species.order = "Enterobacterales"
  species.family = "Enterobacteriaceae"
  species.genus = "Escherichia"
  species.epithet = "coli"
  species.common_name = "E. coli"
end
