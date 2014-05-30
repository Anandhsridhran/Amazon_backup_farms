class ReadingSerializer < ActiveModel::Serializer
  attributes :air_quality, :humidity, :barn_name, :propane_total, :reported_at,
   :system_status, :CO, :AC_power, :water_total
   
  has_many :temperatures
  has_many :ir_feeds
  has_many :curtain_states
  has_many :brooder_heater_states
  has_many :vent_fans

  def barn_name
  	object.barn.name
  end
end
