class ShipmentSerializer < ActiveModel::Serializer
  attributes  :barn_id, :shipment_date, :total_pigs, :total_doa, :pig_supplier, :total_inventory

  def total_inventory
  	object.barn ? object.barn.total_pigs : 0
  end
end
