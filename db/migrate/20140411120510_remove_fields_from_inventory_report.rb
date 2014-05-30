class RemoveFieldsFromInventoryReport < ActiveRecord::Migration
  def change
  	remove_column :inventory_reports, :total_pig_deaths
  	remove_column :inventory_reports, :cause_of_death
  	remove_column :inventory_reports, :total_pigs_treated
  	remove_column :inventory_reports, :medicine_given
  	remove_column :inventory_reports, :dosage
  	remove_column :inventory_reports, :how_administered
  end
end
