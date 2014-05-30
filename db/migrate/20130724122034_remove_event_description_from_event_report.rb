class RemoveEventDescriptionFromEventReport < ActiveRecord::Migration
  def change
  	remove_column :event_reports, :event_description
  end
end
