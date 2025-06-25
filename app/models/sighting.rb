class Sighting < ApplicationRecord
  STATUSES = %w[Pendiente Confirmado Rechazado]
  belongs_to :submitted_by, class_name: "User"
  belongs_to :validated_by, class_name: "User", optional: true
  belongs_to :species
  has_one_attached :photo

  validates :latitude, :longitude, :sighting_date, presence: true
  validates :status, inclusion: { in: STATUSES }

  scope :confirmed, -> { where(status: "Confirmado") }
end
