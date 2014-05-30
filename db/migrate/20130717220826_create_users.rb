class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :owner_type
      t.integer :owner_id
      t.string :crypted_password
      t.string :password_salt
      t.string :single_access_token
      t.string :perishable_token
      t.string :persistence_token

      t.timestamps
    end
  end
end
