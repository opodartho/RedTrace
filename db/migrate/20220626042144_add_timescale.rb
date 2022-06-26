class AddTimescale < ActiveRecord::Migration[7.0]
  def change
    enable_extension('timescaledb') unless extensions.include? 'timescaledb'
  end
end
