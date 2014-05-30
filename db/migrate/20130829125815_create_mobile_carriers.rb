class CreateMobileCarriers < ActiveRecord::Migration
  def change
    create_table :mobile_carriers do |t|
      t.string :name
      t.string :email_to_sms

      t.timestamps
    end
  end
end
