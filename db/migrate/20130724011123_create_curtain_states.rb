class CreateCurtainStates < ActiveRecord::Migration
  def change
    create_table :curtain_states do |t|
      t.integer :reading_id
      t.string :status
    end
  end
end
