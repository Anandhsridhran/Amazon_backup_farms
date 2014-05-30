class CreatePigTreatments < ActiveRecord::Migration
  def change
    create_table :pig_treatments do |t|
      t.integer :inventory_report_id
      t.string :medicine_given
      t.string :dosage
      t.string :how_administered
      t.integer :count
    end
  end
end
