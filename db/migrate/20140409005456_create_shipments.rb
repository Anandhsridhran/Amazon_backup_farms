class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.integer :barn_id
      t.date :shipment_date
      t.integer :total_pigs
      t.integer :total_doa
      t.string :pig_supplier

      t.timestamps
    end
  end
end
