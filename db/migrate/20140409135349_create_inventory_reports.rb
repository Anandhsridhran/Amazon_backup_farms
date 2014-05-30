class CreateInventoryReports < ActiveRecord::Migration
  def change
    create_table :inventory_reports do |t|
      t.integer :barn_id
      t.date :report_date
      t.integer :total_pig_deaths
      t.string :cause_of_death
      t.integer :total_pigs_treated
      t.string :medicine_given
      t.string :dosage
      t.string :how_administered
      t.string :user_initials

      t.timestamps
    end
  end
end
