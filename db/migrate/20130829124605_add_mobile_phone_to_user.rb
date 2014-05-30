class AddMobilePhoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :mobile_phone, :string
    add_column :users, :email_alerts_enabled, :boolean
    add_column :users, :text_alerts_enabled, :boolean
    add_column :users, :mobile_carrier_id, :integer
  end
end
