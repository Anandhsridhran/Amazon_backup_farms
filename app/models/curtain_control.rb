class CurtainControl < ActiveRecord::Base
  attr_accessible :action, :curtain, :barn_configuration_id

  CURTAINS = [1, 2]
  ACTIONS = ["None", "Raise", "Lower"]

  belongs_to :barn_configuration

  validates :curtain, :inclusion => { :in => CURTAINS }
  validates :action, :inclusion => { :in => ACTIONS }

  def self.create_defaults(barn_configuration)
  	# Create default curtain constrols
  	CURTAINS.each do |curtain|
  		cc = CurtainControl.new
  		cc.curtain = curtain
  		cc.action = ACTIONS[0]
  		cc.barn_configuration = barn_configuration
  		cc.save
  	end
  end
end
