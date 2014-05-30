class Admin < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :user

  def farms
  	Farm.all
  end

  def locations
  	Location.all
  end

  def barns
  	Barn.all
  end
  
end
