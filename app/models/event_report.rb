
class EventCodeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    event_codes = EventReport::STATUSES.map {|x| x[0]}
    record.errors.add attribute, "is not valid" if !event_codes.include?(value)
  end
end

class EventReport < ActiveRecord::Base
  attr_accessible :event_code, :input_value, :barn_id, :output_value
  validates :event_code, :presence => true, :event_code => true
  validates :barn_id, :presence => true
  after_save :send_mobile_notification
  belongs_to :barn

  STATUSES = [
  	[1, "Controller started"],
  	[10, "AC power is on and OK"],
  	[1010, "AC power is high"],
  	[1011, "AC power is low (brownout condition)"],
  	[1012, "AC power is off"],
  	[20, "CO level is OK"],
  	[1020, "CO level is high"],
  	[30, "Air quality is OK"],
  	[1030, "Air quality is poor"],
  	[40, "Brooder heater is commanded on"],
  	[41, "Brooder heater is commanded off"],
  	[50, "Vent fan is commanded on"],
  	[51, "Vent fan is commanded off"],
  	[60, "Curtain raise operation started"],
  	[61, "Curtain raise operation ended"],
  	[1061, "Curtain raise operation timed out"],
  	[65, "Curtain lower operation started"],
  	[66, "Curtain lower operation ended"],
  	[1066, "Curtain lower operation timed out"],
  	[70, "Water flow is not continously on"],
  	[1070, "Water flow on timeout reached"],
    [80, "Feed present"],
    [1080, "Feed is empty"]

  ]

  def description
  	STATUSES.each do |status|
  		if (status[0] == self.event_code)
  			return status[1]
  		end
  	end
    ""
  end

  def normal?
    self.event_code < 1000 ? true : false
  end

  def send_mobile_notification
     require 'gcm'
      gcm = GCM.new('AIzaSyAPNI6bfVjElDR0hVK8aco9Am_An5pmmO4')
      users = barn.location.farm.hog_owner.user_id
       registration_ids = UserDevice.where(:user_id=>users).collect(&:regid)
       options = {
          'data' => {
            'message' => self.description
          },
            'collapse_key' => 'updated_state'
        }
      response = gcm.send_notification(registration_ids, options)
      p "response"
      p response

  end
  
end



