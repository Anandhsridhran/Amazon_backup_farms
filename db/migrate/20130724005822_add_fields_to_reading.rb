class AddFieldsToReading < ActiveRecord::Migration
  def change
    add_column :readings, :system_status, :string
    add_column :readings, :CO, :string
    add_column :readings, :AC_power, :string
    remove_column :readings, :IR_feed
    remove_column :readings, :curtain_state
  end
end
