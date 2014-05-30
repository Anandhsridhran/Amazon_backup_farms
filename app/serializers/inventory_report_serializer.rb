class InventoryReportSerializer < ActiveModel::Serializer
  attributes :barn_id, :report_date, :user_initials, :total_inventory

  has_many :pig_deaths
  has_many :pig_treatments

  def total_inventory
  	object.barn ? object.barn.total_pigs : 0
  end

end
