class CreateVentFans < ActiveRecord::Migration
  def change
    create_table :vent_fans do |t|
      t.integer :reading_id
      t.integer :value
    end
  end
end
