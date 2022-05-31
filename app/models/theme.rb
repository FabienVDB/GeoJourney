class Theme < ApplicationRecord
  has_many :itineraries
  validates :name, presence: true, uniqueness: true
end
