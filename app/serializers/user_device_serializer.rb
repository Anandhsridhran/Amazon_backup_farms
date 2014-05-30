class UserDeviceSerializer < ActiveModel::Serializer
  attributes  :user_id, :regid, :is_active
end
