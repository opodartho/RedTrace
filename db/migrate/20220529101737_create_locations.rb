class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.float :longitude, null: false
      t.float :latitude, null: false

      t.timestamps

      t.index %i[latitude longitude]
    end
  end
end
