class BarnConfiguration < ActiveRecord::Base
  attr_accessible :building_temperature, :location_id, :propane_sensor_reset, :water_sensor_reset
  attr_accessible :zone_temperatures_attributes, :curtain_controls_attributes
  attr_accessible :heater_controls_attributes, :vent_fan_controls_attributes

  DEFAULT_TEMPERATURE = 72

  belongs_to :barn
  
  has_many :zone_temperatures, :dependent => :destroy
  has_many :curtain_controls, :dependent => :destroy
  has_many :heater_controls, :dependent => :destroy
  has_many :vent_fan_controls, :dependent => :destroy

  accepts_nested_attributes_for   :zone_temperatures
  accepts_nested_attributes_for   :curtain_controls
  accepts_nested_attributes_for   :heater_controls
  accepts_nested_attributes_for   :vent_fan_controls

  def self.create_default(barn)
  	# Create default barn configuration for given barn
  	bc = BarnConfiguration.new
  	bc.building_temperature = DEFAULT_TEMPERATURE
  	bc.propane_sensor_reset = false
  	bc.water_sensor_reset = false
  	bc.barn = barn
  	bc.save

  	ZoneTemperature.create_defaults(bc)
  	CurtainControl.create_defaults(bc)
  	HeaterControl.create_defaults(bc)
  	VentFanControl.create_defaults(bc)
  end

end
