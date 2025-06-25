class Species < ApplicationRecord
  enum :kingdom, [ :animalia, :plantae, :fungi, :protista, :bacteria, :archaea ]
end

# == Schema Information
#
# Table name: species
#
#  id              :bigint           not null, primary key
#  class_name      :string
#  common_name     :string
#  epithet         :string           not null
#  family          :string
#  genus           :string           not null
#  kingdom         :integer          not null
#  order           :string
#  phylum          :string
#  scientific_name :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_species_on_scientific_name  (scientific_name) UNIQUE
#
