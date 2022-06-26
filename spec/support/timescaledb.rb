RSpec.configure do |config|
  config.before(:suite) do
    # ensure the hypertable_name hypertable is setup correctly
    ActiveRecord::Base.connection.execute(
      'DROP TRIGGER IF EXISTS ts_insert_blocker ON locations;',
    )
    ActiveRecord::Base.connection.execute(
      "SELECT create_hypertable('locations','tracked_at', if_not_exists => TRUE);",
    )
    # has_hypertables_sql = "SELECT * FROM timescaledb_information.hypertable WHERE table_name = 'hypertable_name';"
    # if ActiveRecord::Base.connection.execute(has_hypertables_sql).to_a.empty?
    # raise "TimescaleDB missing hypertable on 'hypertable_name' table"
    # end
  end
end
