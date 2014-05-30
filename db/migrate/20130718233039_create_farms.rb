class CreateFarms < ActiveRecord::Migration
  def change
    create_table :farms do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :postal_code

      t.timestamps
    end
  end
end
