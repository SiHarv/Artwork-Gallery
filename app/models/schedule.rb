class Schedule < ApplicationRecord
  belongs_to :art
  belongs_to :location
  has_many :schedules
  belongs_to :user



  validates :date, :location_id, :description, :art_id, presence: true
end

