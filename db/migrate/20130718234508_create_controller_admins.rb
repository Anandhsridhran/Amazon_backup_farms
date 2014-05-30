class CreateControllerAdmins < ActiveRecord::Migration
  def change
    create_table :controller_admins do |t|
      t.integer :location_id

      t.timestamps
    end
  end
end
