class Picture < ActiveRecord::Base
  attr_accessible :caption, :farm_id, :photo

  belongs_to :farm
  has_attached_file :photo, :styles => { :medium => "300x300", :thumb => "150x150" }, 
    :default_url => '/images/no_profile_photo_thumb.jpg' 
    
end
