class CreateHeaterControls < ActiveRecord::Migration
  def change
    create_table :heater_controls do |t|
      t.integer :heater
      t.string :action
      t.string :mode
      t.integer :period
      t.integer :location_configuration_id

      t.timestamps
    end
  end
end
