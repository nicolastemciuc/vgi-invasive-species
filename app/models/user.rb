class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sightings, foreign_key: :submitted_by_id
  has_many :validated_sightings, class_name: "Sighting", foreign_key: :validated_by_id

  enum :role, [ :citizen, :expert, :admin ]
end
