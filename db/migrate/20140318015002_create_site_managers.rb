class CreateSiteManagers < ActiveRecord::Migration
  def change
    create_table :site_managers do |t|
      t.integer :user_id
      t.integer :location_id

      t.timestamps
    end
  end
end
