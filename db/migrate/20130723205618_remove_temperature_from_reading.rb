class RemoveTemperatureFromReading < ActiveRecord::Migration
  def change
    remove_column :readings, :temperature, :temperature2, :temperature3
  end

end
