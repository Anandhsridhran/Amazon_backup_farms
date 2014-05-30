class CreateCurtainControls < ActiveRecord::Migration
  def change
    create_table :curtain_controls do |t|
      t.integer :curtain
      t.string :action
      t.integer :location_configuration_id

      t.timestamps
    end
  end
end
