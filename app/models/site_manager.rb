class SiteManager < ActiveRecord::Base
  attr_accessible :location_id, :user_id

  belongs_to :user
  belongs_to :location

  has_many :barns, :through => :location
  has_many :event_reports, :through => :location

  def locations
  	@locations = []
  	@locations << self.location
  end

  def name
  	self.user.name
  end

end
