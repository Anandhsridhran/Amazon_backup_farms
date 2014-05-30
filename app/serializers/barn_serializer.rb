class BarnSerializer < ActiveModel::Serializer
  attributes :barn_id, :name, :system_status

  def system_status
  	object.system_status
  end

  def barn_id
  	object.id
  end

end
