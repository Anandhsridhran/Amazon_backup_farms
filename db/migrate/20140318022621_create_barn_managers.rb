class CreateBarnManagers < ActiveRecord::Migration
  def change
    create_table :barn_managers do |t|
      t.integer :user_id
      t.integer :barn_id

      t.timestamps
    end
  end
end
