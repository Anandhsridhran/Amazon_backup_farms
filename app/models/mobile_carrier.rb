class MobileCarrier < ActiveRecord::Base
  attr_accessible :email_to_sms, :name

  def email_for_sms(mobile_phone)
  	# Construct the email address that would send a text message 
  	mobile_phone.gsub(/[^0-9]/, "") + "@" + self.email_to_sms
  end

end
