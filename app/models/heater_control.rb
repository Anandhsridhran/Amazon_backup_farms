class HeaterControl < ActiveRecord::Base
  attr_accessible :action, :heater, :barn_configuration_id, :mode, :period

  HEATERS = [1, 2]
  MODES = ["Auto", "Manual", "Override"]
  ACTIONS = ["None", "On", "Off"]

  belongs_to :barn_configuration

  validates :heater, :inclusion => { :in => HEATERS } 
  validates :mode, :inclusion => { :in => MODES }
  validates :action, :inclusion => { :in => ACTIONS }

  def self.create_defaults(barn_configuration)
  	# Create default heater constrols
  	HEATERS.each do |heater|
  		hc = HeaterControl.new
  		hc.heater = heater
  		hc.mode = MODES[0]
  		hc.action = ACTIONS[0]
  		hc.period = 0
  		hc.barn_configuration = barn_configuration
  		hc.save
  	end
  end

end
