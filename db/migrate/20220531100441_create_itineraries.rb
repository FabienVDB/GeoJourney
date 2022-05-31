class CreateItineraries < ActiveRecord::Migration[6.1]
  def change
    create_table :itineraries do |t|
      t.references :area, null: false, foreign_key: true
      t.references :theme, null: false, foreign_key: true
      t.string :name
      t.string :summary
      t.text :content

      t.timestamps
    end
  end
end
