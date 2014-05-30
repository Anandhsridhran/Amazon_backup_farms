class FarmSerializer < ActiveModel::Serializer
  attributes :farm_id,  :name,  :system_status, :street_address, :city,  :state, :postal_code

  def system_status
  	object.system_status
  end

  def farm_id
  	object.id
  end

end
