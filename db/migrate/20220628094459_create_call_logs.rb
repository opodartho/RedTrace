class CreateCallLogs < ActiveRecord::Migration[7.0]
  def up
    create_table :call_logs, id: false do |t|
      t.references :user, null: false, index: true
      t.references :company, null: false, index: true
      t.string :msisdn, null: false
      t.integer :call_type, null: false, default: 0
      t.integer :duration, null: false
      t.timestamp :start_time, null: false
      t.timestamp :end_time, null: false

      t.timestamps
    end

    execute "SELECT create_hypertable('call_logs','start_time', chunk_time_interval => INTERVAL '1 day');"
    execute 'CREATE INDEX call_logs_company_id_start_time ON call_logs (company_id, start_time DESC);'
    execute 'CREATE INDEX call_logs_user_id_start_time ON call_logs (user_id, start_time DESC);'
  end

  def down
    drop_table :call_logs
  end
end
