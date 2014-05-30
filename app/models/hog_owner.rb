class HogOwner < ActiveRecord::Base
  attr_accessible :user_id

  has_many :farms
  belongs_to :user
  has_many :locations, :through => :farms
  has_many :barns, :through => :locations

  def name
  	self.user.name
  end
 
end
