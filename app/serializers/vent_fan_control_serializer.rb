class VentFanControlSerializer < ActiveModel::Serializer
  attributes :id, :fan, :mode, :period, :speed
end
