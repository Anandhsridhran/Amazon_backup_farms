class AddTotalPigsToBarns < ActiveRecord::Migration
  def change
    add_column :barns, :total_pigs, :integer, default: 0
  end
end
