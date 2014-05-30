class CreateIrFeeds < ActiveRecord::Migration
  def change
    create_table :ir_feeds do |t|
      t.integer :reading_id
      t.string :status
    end
  end
end
