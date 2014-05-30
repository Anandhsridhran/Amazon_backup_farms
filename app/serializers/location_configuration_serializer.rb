class LocationConfigurationSerializer < ActiveModel::Serializer
  # Used to customize the JSON rendered for this object
  attributes :location_name, :building_temperature, :propane_sensor_reset, :water_sensor_reset
  attributes :updated_at

  has_many :zone_temperatures
  has_many :curtain_controls
  has_many :heater_controls
  has_many :vent_fan_controls

  def location_name
  	object.location.name
  end

end
