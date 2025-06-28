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
#  sighting_date        :date
#  status               :string
#  validated_at         :datetime
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
