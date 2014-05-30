class LocationSerializer < ActiveModel::Serializer
  attributes :location_id, :name, :system_status, :street_address, :postal_code, :city, :state

  def system_status
  	object.system_status
  end

  def location_id
  	object.id
  end

end
