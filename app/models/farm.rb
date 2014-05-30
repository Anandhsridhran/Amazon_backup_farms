class Farm < ActiveRecord::Base
  attr_accessible :city, :name, :postal_code, :state, :street_address, :hog_owner_id


  has_one :farm_owner
  belongs_to :hog_owner
  has_many :locations
  has_many :barns, :through => :locations
  has_many :event_reports, :through => :barns
  has_many :users
  has_many :pictures
  has_many :event_reports, :through => :locations

  def system_status
  	# System status of farm depends on status of its locations
  	self.locations.each do |location|
  		if location.system_status != "OK"
  			return location.system_status
  		end
  	end
  	"OK"
  end

end
