class CreateBarns < ActiveRecord::Migration
  def change
    create_table :barns do |t|
      t.string :name
      t.integer :location_id
      t.timestamps
    end
    remove_column :readings, :location_id
    add_column :readings, :barn_id, :integer
    remove_column :event_reports, :location_id
    add_column :event_reports, :barn_id, :integer
    remove_column :controller_admins, :location_id
    add_column :controller_admins, :barn_id, :integer
  end
end
