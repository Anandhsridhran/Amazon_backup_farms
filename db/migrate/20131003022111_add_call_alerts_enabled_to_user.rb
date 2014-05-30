class AddCallAlertsEnabledToUser < ActiveRecord::Migration
  def change
    add_column :users, :call_alerts_enabled, :boolean
  end
end
