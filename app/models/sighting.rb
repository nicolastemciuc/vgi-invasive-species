class Sighting < ApplicationRecord
  belongs_to :submitted_by, class_name: "User"
  belongs_to :validated_by, class_name: "User", optional: true
  belongs_to :species
  has_one_attached :photo

  validates :sighting_date, presence: true
  enum :status, { pending: "Pendiente", confirmed: "Confirmado", rejected: "Rechazado" }

  def status_value
    self.class.statuses[status]
  end
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
#  index_sightings_on_species_user_point  (species_id, submitted_by_id, st_astext(point)) UNIQUE
#  index_sightings_on_submitted_by_id     (submitted_by_id)
#  index_sightings_on_validated_by_id     (validated_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (submitted_by_id => users.id)
#  fk_rails_...  (validated_by_id => users.id)
#
