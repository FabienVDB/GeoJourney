class CreateSites < ActiveRecord::Migration[6.1]
  def change
    create_table :sites do |t|
      t.references :itinerary, null: false, foreign_key: true
      t.string :name
      t.text :summary
      t.integer :stage
      t.string :location
      t.float :latitude
      t.float :longitude
      t.text :content
      t.integer :duration_in_minutes

      t.timestamps
    end
  end
end
