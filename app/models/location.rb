class Location < ActiveRecord::Base
  attr_accessible :city, :farm_id, :name, :postal_code, :state, :street_address

  has_many :barns
  belongs_to :farm
  has_many :event_reports, :through => :barns
  has_one :site_manager
  has_one :location_configuration, :dependent => :destroy

  validates :name, :length => { :minimum => 2 }
  validates :state, :length => { :minimum => 2 }
  validates :postal_code, :length => { :minimum => 5 }
  validates :city, :length => { :minimum => 2 }
  validates :street_address, :length => { :minimum => 2 }

  def system_status
    # System status of location depends on status of its barns
    self.barns.each do |barn|
      if barn.system_status != "OK"
        return barn.system_status
      end
    end
    "OK"
  end

end
