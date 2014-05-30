class ControllerAdmin < ActiveRecord::Base
  attr_accessible :barn_id
  attr_accessible :user_attributes

  has_one :user, :as => :owner, :dependent => :destroy
  belongs_to :barn

  accepts_nested_attributes_for :user

end
