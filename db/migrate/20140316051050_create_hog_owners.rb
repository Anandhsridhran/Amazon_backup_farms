class CreateHogOwners < ActiveRecord::Migration
  def change
    create_table :hog_owners do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
