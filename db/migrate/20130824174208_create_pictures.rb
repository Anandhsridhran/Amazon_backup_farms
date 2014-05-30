class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :farm_id
      t.string :caption

      t.timestamps
    end
  end
end
