class Sighting < ApplicationRecord
  belongs_to :submitted_by, class_name: "User"
  belongs_to :validated_by, class_name: "User", optional: true
  belongs_to :species

  validates :latitude, :longitude, :sighting_date, presence: true
  validates :status, inclusion: { in: %w[Pendiente Confirmado Rechazado] }
end
