class Itinerary < ApplicationRecord
  belongs_to :area
  belongs_to :theme
  # belongs_to :user
  has_many :sites, dependent: :destroy
  # belongs_to :favorite, optional: false, dependent: :destroy
  # has_one_attached :photo

  validates :area, presence: true
  validates :theme, presence: true
  validates :name, presence: true, uniqueness: true
  validates :summary, presence: true
  validates :content, presence: true
end
