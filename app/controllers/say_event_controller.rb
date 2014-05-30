require 'twilio-ruby'

class SayEventController < ApplicationController
  def show
  	# Say the event given by the event report
  	event_report = EventReport.find(params[:id])
    status_message = "This is Farm Central. The following event has occurred at "
  	status_message += event_report.location.name + ". " + event_report.description

  	response = Twilio::TwiML::Response.new do |r|
  		r.Say(status_message, :voice => 'alice')
  	end

		respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: response.text }
    end
  end

end
