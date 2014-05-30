class Barn < ActiveRecord::Base
  attr_accessible :name, :location_id

  has_one :barn_manager
  has_one :barn_configuration, :dependent => :destroy
  belongs_to :location

  has_many :readings, :dependent => :destroy
  has_many :event_reports, :dependent => :destroy
  has_many :shipments, :dependent => :destroy
  has_many :inventory_reports, :dependent => :destroy
  has_one :controller_admin, :dependent => :destroy

  validates :name, :length => { :minimum => 2 }

  def system_status
  	if self.readings.last
  		return self.readings.last.system_status
  	else
  		return "Unknown"
  	end
  end

end
