class CreateEventReports < ActiveRecord::Migration
  def change
    create_table :event_reports do |t|
      t.integer :location_id
      t.integer :input_value
      t.integer :output_value
      t.string :event_description
      t.integer :event_code

      t.timestamps
    end
  end
end
