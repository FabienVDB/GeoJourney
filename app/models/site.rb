class Site < ApplicationRecord
  belongs_to :itinerary
  has_one_attached :photo

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # !! Uncomment the 2 lines below after seed !!
  # validates :name, presence: true, uniqueness: true
  # validates :summary, presence: true

  # validates :content, presence: true
  validates :stage, presence: true, numericality: { only_integer: true, greater_than: 0 }
  # validates :longitude, presence: true
  # validates :latitude, presence: true
  validates :duration_in_minutes, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
