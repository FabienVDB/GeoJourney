class AddDurationInDaysToItineraries < ActiveRecord::Migration[6.1]
  def change
    add_column :itineraries, :duration_in_days, :integer
  end
end
