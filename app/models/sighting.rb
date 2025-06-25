class Sighting < ApplicationRecord
  belongs_to :submitted_by, class_name: "User"
  belongs_to :validated_by, class_name: "User", optional: true
  belongs_to :species
  has_one_attached :photo

  validates :latitude, :longitude, :sighting_date, presence: true
  enum :status, { pending: "Pendiente", confirmed: "Confirmado", rejected: "Rechazado" }

  def status_value
    self.class.statuses[status]
  end
end
