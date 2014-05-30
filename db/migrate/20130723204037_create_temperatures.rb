class CreateTemperatures < ActiveRecord::Migration
  def change
    create_table :temperatures do |t|
      t.integer :reading_id
      t.integer :value

      t.timestamps
    end
  end
end
