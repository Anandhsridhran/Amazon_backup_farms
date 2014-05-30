require 'twilio-ruby'

class OutboundCaller

	def initialize
		# Twilio API credentials 
		account_sid = "ACd9c7613912694a96fc5e4dfd9e48b5d9"
		auth_token = "3d083fd10ef77fa10e9949be4d479bd7"
		@calling_number = '+17329933085'

		# set up a client to talk to the Twilio REST API
		@client = Twilio::REST::Client.new account_sid, auth_token
	end

	def make_call(to_number, event_report)
		url = 'http://nano.amfnano.com:3000/say_event/'+event_report.id.to_s+'.xml'
		call = @client.account.calls.create(:from => @calling_number, :to => to_number, :url => url)
	end

end
