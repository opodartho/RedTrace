class CreateLocations < ActiveRecord::Migration[7.0]
  def up
    create_table :locations, id: false do |t|
      t.references :company, null: false, index: true
      t.references :user, null: false, index: true
      t.float :longitude, null: false
      t.float :latitude, null: false

      t.timestamp :tracked_at, null: false

      t.timestamps

      t.index %i[latitude longitude]
    end

    execute "SELECT create_hypertable('locations','tracked_at');"
    execute 'CREATE INDEX locations_company_id_tracked_at ON locations (company_id, tracked_at DESC);'
  end

  def down
    drop_table :locations
  end
end
