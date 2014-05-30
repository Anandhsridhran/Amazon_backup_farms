class InventoryReport < ActiveRecord::Base
  attr_accessible :barn_id, :report_date, :user_initials
  attr_accessible :pig_deaths_attributes, :pig_treatments_attributes

  belongs_to :barn
  has_many :pig_deaths, :dependent => :destroy
  has_many :pig_treatments, :dependent => :destroy

  accepts_nested_attributes_for :pig_treatments
  accepts_nested_attributes_for :pig_deaths

end
