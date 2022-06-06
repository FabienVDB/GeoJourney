class AddUserReferencesToItineraries < ActiveRecord::Migration[6.1]
  def change
    add_reference :itineraries, :user, foreign_key: true
  end
end
