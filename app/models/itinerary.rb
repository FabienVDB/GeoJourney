class Itinerary < ApplicationRecord
  belongs_to :area
  belongs_to :theme
  belongs_to :user
  has_many :sites, dependent: :destroy
  has_many :sites, -> { order(:stage) }, dependent: :destroy
  # belongs_to :favorite, optional: false, dependent: :destroy
  has_one_attached :photo
  accepts_nested_attributes_for :sites, allow_destroy: true

  validates :area, presence: true
  validates :theme, presence: true
  validates :name, presence: true, uniqueness: true
  validates :summary, presence: true
  # validates :content, presence: true

  include PgSearch::Model
  pg_search_scope :global_search,
    against: :duration_in_days,
    associated_against: {
      area: :name,
      theme: :name
    },
    using: {
      tsearch: { prefix: true }
    }

end
