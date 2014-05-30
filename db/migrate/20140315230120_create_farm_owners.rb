class CreateFarmOwners < ActiveRecord::Migration
  def change
    create_table :farm_owners do |t|
      t.integer :user_id
      t.integer :farm_id

      t.timestamps
    end
  end
end
