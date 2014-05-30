class CreateUserDevices < ActiveRecord::Migration
  def change
    create_table :user_devices do |t|
      t.integer :user_id
      t.text :regid
      t.boolean :is_active, :default=>true

      t.timestamps
    end
  end
end
