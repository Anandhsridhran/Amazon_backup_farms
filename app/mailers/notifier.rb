class Notifier < ActionMailer::Base
  default from: "noreply@amfnano.com"

  def new_event(user, event)
  	@event = event
  	mail(:subject => "New event: #{event.description}", :to => user.email)
  end

  def new_event_for_sms(user, event)
  	if user.mobile_carrier && !user.mobile_phone.blank?
		@event = event
  		email = user.mobile_carrier.email_for_sms(user.mobile_phone)
  		mail(:subject => "New event at #{event.location.name}", :to => email)
  	end
  end
end
