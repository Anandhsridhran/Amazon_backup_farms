class ZoneTemperature < ActiveRecord::Base
  attr_accessible :location_configuration_id, :temperature, :zone

  DEFAULT_TEMPERATURE = 72

  ZONES = [1, 2, 3]

  belongs_to :barn_configuration

  validates :zone, :inclusion => { :in => ZONES } 

  def self.create_defaults(barn_configuration)
  	# Create default zone temperatures
  	ZONES.each do |zone|
  		zt = ZoneTemperature.new
  		zt.zone = zone
  		zt.temperature = DEFAULT_TEMPERATURE
  		zt.barn_configuration = barn_configuration
  		zt.save
  	end
  end

end
