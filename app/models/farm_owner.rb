class FarmOwner < ActiveRecord::Base
  attr_accessible :farm_id, :user_id

  belongs_to :farm
  belongs_to :user
  
  has_many :barns, :through => :farm
  has_many :event_reports, :through => :farm

  def name
  	self.user.name
  end

  def locations
  	self.farm.locations
  end
  
end
