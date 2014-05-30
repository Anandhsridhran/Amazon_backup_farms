class RenameLocationConfig < ActiveRecord::Migration
  def change
  	# rename_column :barn_configurations, :location_id, :barn_id
  	# rename_column :curtain_controls, :location_configuration_id, :barn_configuration_id
  	# rename_column :heater_controls, :location_configuration_id, :barn_configuration_id
  	# rename_column :vent_fan_controls, :location_configuration_id, :barn_configuration_id
	rename_column :zone_temperatures, :location_configuration_id, :barn_configuration_id
  end
end
