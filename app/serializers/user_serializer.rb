class UserSerializer < ActiveModel::Serializer
  attributes :user_id, :single_access_token, :first_name, :last_name, :role, :email, :username, 
  	:barn_id, :location_id, :farm_id

  def user_id
  	object.id
  end

end
