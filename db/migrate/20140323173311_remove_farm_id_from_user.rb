class RemoveFarmIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :farm_id
  end
end
