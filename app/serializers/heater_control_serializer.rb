class HeaterControlSerializer < ActiveModel::Serializer
  attributes :id, :heater, :action, :mode, :period
end
