class BarnManager < ActiveRecord::Base
  attr_accessible :barn_id, :user_id

  belongs_to :user
  belongs_to :barn
  has_many :event_reports, :through => :barn

  def barns
  	@barns = []
  	@barns << self.barn
  end

  def locations
  	@locations = []
  	@locations << self.barn.location
  end

  def name
  	self.user.name
  end
  
end
