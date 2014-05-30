class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :temperature
      t.integer :temperature2
      t.integer :temperature3
      t.integer :humidity
      t.integer :water_total
      t.integer :propane_total
      t.string :air_quality
      t.string :IR_feed
      t.string :curtain_state
      t.integer :location_id
      t.datetime :reported_at

      t.timestamps
    end
  end
end
