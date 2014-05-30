class CreateZoneTemperatures < ActiveRecord::Migration
  def change
    create_table :zone_temperatures do |t|
      t.integer :zone
      t.integer :temperature
      t.integer :location_configuration_id

      t.timestamps
    end
  end
end
