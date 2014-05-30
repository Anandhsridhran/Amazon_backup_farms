class CreateBrooderHeaterStates < ActiveRecord::Migration
  def change
    create_table :brooder_heater_states do |t|
      t.integer :reading_id
      t.string :status
    end
  end
end
