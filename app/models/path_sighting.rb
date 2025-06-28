class PathSighting < Sighting
  validates :path, presence: true
end

# == Schema Information
#
# Table name: sightings
#
#  id                   :bigint           not null, primary key
#  description          :text
#  location_description :text
#  path                 :geography        linestring, 4326
#  point                :geography        point, 4326
#  sighting_date        :date
#  status               :string
#  type                 :string           not null
#  validated_at         :datetime
#  zone                 :geography        polygon, 4326
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  species_id           :integer
#  submitted_by_id      :bigint           not null
#  validated_by_id      :bigint
#
# Indexes
#
#  index_sightings_on_submitted_by_id  (submitted_by_id)
#  index_sightings_on_validated_by_id  (validated_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (submitted_by_id => users.id)
#  fk_rails_...  (validated_by_id => users.id)
#
