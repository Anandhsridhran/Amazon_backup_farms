class CreateVentFanControls < ActiveRecord::Migration
  def change
    create_table :vent_fan_controls do |t|
      t.integer :fan
      t.integer :speed
      t.string :mode
      t.integer :period
      t.integer :location_configuration_id

      t.timestamps
    end
  end
end
