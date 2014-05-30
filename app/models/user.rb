# Email format validator
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ActiveRecord::Base
  acts_as_authentic do |c|
    # c.logged_in_timeout(20.minutes) 
  end
  
  attr_accessible :crypted_password, :email, :first_name, :last_name, :owner_id, :owner_type, 
  :password_salt, :perishable_token, :persistence_token, :single_access_token, :username,
  :password, :password_confirmation, :mobile_phone, :email_alerts_enabled, 
  :text_alerts_enabled, :call_alerts_enabled, :mobile_carrier_id

  # Validations
  validates :first_name, :length => { :minimum => 1 }
  validates :last_name, :length => { :minimum => 2 }
  validates :email, :uniqueness => true, :presence => true, :email => true
  validates :username, :uniqueness => true

  validates_format_of :mobile_phone, 
    :message => "must be a valid telephone number.",
    :with => /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/,
    :allow_nil => true
  
  # Relationships
  belongs_to :owner, :polymorphic => true
  has_many :user_devices

  # Types of users
  ROLES = [ "HogOwner", "FarmOwner", "SiteManager", "BarnManager", "Admin", "ControllerAdmin"  ]
  
  def is_hog_owner?
    owner_type == "HogOwner"
  end

  def is_farm_owner?
    owner_type == "FarmOwner"
  end
  
  def is_site_manager?
    owner_type == "SiteManager"
  end

  def is_barn_manager?
    owner_type == "BarnManager"
  end

  def is_admin?
    owner_type == "Admin"
  end

  def is_controller_admin?
  	owner_type == "ControllerAdmin"
  end
  
  def name
    first_name + " " + last_name
  end

  def build_owner(object_id)
    if self.is_farm_owner?
      owner = FarmOwner.new
      owner.farm = Farm.find(object_id)
    elsif self.is_site_manager?
      owner = SiteManager.new
      owner.location = Location.find(object_id)
    elsif self.is_hog_owner?
      owner = HogOwner.new   
    elsif self.is_barn_manager?
      owner = BarnManager.new
      owner.barn = Barn.find(object_id)
    end
    owner
  end

  def managed_objects
    # Return farms, sites or barns managed by this user
    managed = []
    if self.is_farm_owner?
      managed << owner.farm
    elsif self.is_site_manager?
      managed << owner.location
    elsif self.is_hog_owner?
      managed = owner.farms
    else
      managed << owner.barn
    end
    managed
  end
      



  def role
    owner_type
  end

  def barn_id
    if self.is_controller_admin? || self.is_barn_manager?
      self.owner.barn_id
    else
      0
    end
  end

  def location_id
  	if self.is_site_manager?
  		self.owner.location.id
  	elsif self.is_barn_manager?
      self.owner.barn.location.id
    else     
  		0
  	end
  end

  def farm_id
    if self.is_farm_owner?
      self.owner.farm.id
    elsif self.is_site_manager?
      self.owner.location.farm.id
    elsif self.is_barn_manager?
      self.owner.barn.location.farm.id
    else     
      0
    end
  end

  def farm
    Farm.find(farm_id)
  end

  def farms
    return self.owner.farms if self.is_hog_owner? || self.is_admin?
    @farms = []
    @farms << farm
  end

  def barns
    self.owner.barns
  end

  def locations
    self.owner.locations
  end

  def event_reports
    self.owner.event_reports
  end


  def mobile_carrier
    if self.mobile_carrier_id
      MobileCarrier.find(self.mobile_carrier_id)
    else
      nil
    end
  end

  def name
    self.first_name + " " + self.last_name
  end
  
  # Notify this user that an event has occurred
  def notify(event_report)
    # Notify via email
    Notifier.new_event(self, event_report).deliver if self.email_alerts_enabled
    # Notify via SMS (text)
    Notifier.new_event_for_sms(self, event_report).deliver if self.text_alerts_enabled
    # Call user via phone call if the event is abnormal
    if (!event_report.normal? && self.call_alerts_enabled)
      caller = OutboundCaller.new
      caller.make_call("+1"+self.mobile_phone.gsub(/[^0-9]/, ""), event_report)
    end
  end

  # Allow user to log in using either username or email address
  def self.find_by_username_or_email(login) 
    find_by_username(login) || find_by_email(login) 
  end 
  
  def self.generate_new_password
    password = Base64.encode64(Digest::SHA1.digest("#{rand(1<<64)}/#{Time.now.to_f}/#{Process.pid}"))[0..7]
    return password
  end

    
end
