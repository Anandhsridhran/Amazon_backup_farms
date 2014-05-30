class CreateLocationConfigurations < ActiveRecord::Migration
  def change
    create_table :location_configurations do |t|
      t.integer :building_temperature
      t.boolean :water_sensor_reset
      t.boolean :propane_sensor_reset
      t.integer :location_id

      t.timestamps
    end
  end
end
