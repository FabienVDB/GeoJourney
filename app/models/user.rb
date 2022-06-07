class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :itineraries
  has_many :favorites, dependent: :destroy

  accepts_nested_attributes_for :itineraries, reject_if: :all_blank, allow_destroy: true
end
