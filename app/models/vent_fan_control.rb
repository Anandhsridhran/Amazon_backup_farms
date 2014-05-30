class VentFanControl < ActiveRecord::Base
  attr_accessible :fan, :barn_configuration_id, :mode, :period, :speed

  FANS = [1, 2, 3]
  MODES = ["Auto", "Manual", "Override"]
  

  belongs_to :barn_configuration

  validates :fan, :inclusion => { :in => FANS } 
  validates :mode, :inclusion => { :in => MODES }

  def self.create_defaults(barn_configuration)
  	# Create default vent fan constrols
  	FANS.each do |fan|
  		vfc = VentFanControl.new
  		vfc.fan = fan
  		vfc.mode = MODES[0]
  		vfc.speed = 0
  		vfc.period = 0
  		vfc.barn_configuration = barn_configuration
  		vfc.save
  	end
  end
end
