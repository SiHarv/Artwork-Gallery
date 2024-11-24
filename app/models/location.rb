class Location < ApplicationRecord
  belongs_to :user
  has_many :schedules
  # Add validations if needed
  validates :name_of_place, :address, :email, :phone_number, :notes, presence: true

  def formatted_location
    "#{name_of_place}, #{address}"
  end

end
