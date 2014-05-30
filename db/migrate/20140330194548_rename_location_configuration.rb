class RenameLocationConfiguration < ActiveRecord::Migration
  def change
  	rename_table :location_configurations, :barn_configurations
  end
end
