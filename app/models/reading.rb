class Reading < ActiveRecord::Base
  attr_accessible :air_quality, :humidity, :barn_id, :propane_total, :reported_at
  attr_accessible :system_status, :CO, :AC_power, :water_total
  attr_accessible :temperatures_attributes, :ir_feeds_attributes, :curtain_states_attributes
  attr_accessible :brooder_heater_states_attributes, :vent_fans_attributes

  belongs_to :barn
  has_many :temperatures
  has_many :ir_feeds
  has_many :curtain_states
  has_many :brooder_heater_states
  has_many :vent_fans

  accepts_nested_attributes_for :temperatures
  accepts_nested_attributes_for :ir_feeds
  accepts_nested_attributes_for :curtain_states
  accepts_nested_attributes_for :brooder_heater_states
  accepts_nested_attributes_for :vent_fans

  def max_temperature
    max = 0
    self.temperatures.each {|t| max = t.value if t.value > max }
    max
  end
  
end
