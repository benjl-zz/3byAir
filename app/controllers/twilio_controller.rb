class TwilioController < ApplicationController

	def send_text_message
    number_to_send_to = params[:number_to_send_to]
 
    twilio_sid = "AC5328128ca782cfad1d1b621ab0a894b2"
    twilio_token = "f8465283cef782dda6215ea299991248"
    twilio_phone_number = "6136991109"
 
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
 
    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "This is an message. It gets sent to #{number_to_send_to}"
    )
  end

end
