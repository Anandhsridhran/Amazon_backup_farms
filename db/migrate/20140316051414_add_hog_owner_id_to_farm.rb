class AddHogOwnerIdToFarm < ActiveRecord::Migration
  def change
    add_column :farms, :hog_owner_id, :integer
  end
end
