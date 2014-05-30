class UserDevice < ActiveRecord::Base
  attr_accessible :is_active, :regid, :user_id
  validates :regid, :user_id, :presence=>true
  validates :regid, :uniqueness => true
  belongs_to :user
end

