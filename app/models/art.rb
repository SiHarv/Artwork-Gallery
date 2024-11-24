class Art < ApplicationRecord
  belongs_to :user
  has_many :schedules
  has_many :schedules, dependent: :destroy
  has_many_attached :images
  has_one_attached :video
  validates :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :medium, presence: true
  validates :status, presence: true
  validates :type_of_art, presence: true
  validates :dimension, presence: true
  validate :image_limit


  private
  def image_limit
    if images.length > 4
      errors.add(:images, "You can upload a maximum of 4 images")
    end
  end
end
