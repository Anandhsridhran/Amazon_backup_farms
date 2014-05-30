class CreatePigDeaths < ActiveRecord::Migration
  def change
    create_table :pig_deaths do |t|
      t.integer :inventory_report_id
      t.string :cause
      t.integer :count
    end
  end
end
