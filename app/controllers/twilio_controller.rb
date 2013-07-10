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

	def receive_text_message
		#get 10 latest products
		@products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})

		#receive
		message_body = params["Body"]
	    from_number = params["From"]
 		
 		#send
    	number_to_send_to = from_number
	 
	    twilio_sid = "AC5328128ca782cfad1d1b621ab0a894b2"
	    twilio_token = "f8465283cef782dda6215ea299991248"
	    twilio_phone_number = "6136991109"
	 
	    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
	 	
	    #prepare products for sms by adding a newline %0a between them 

	   	
	    list = ""
		@products.each do |item|
			list + item.title + "%0a"
		end

	    @twilio_client.account.sms.messages.create(
	      :from => "+1#{twilio_phone_number}",
	      :to => number_to_send_to,
	      :body => "#{list}"
	    )
	end

	private
	#takes an array and returns a string with each array item on a newline
	def product_to_sms_list(prod)
		list = ""

		prod.each do |item|
			list + item.title + "%0a"
		end
		return list
	end

end
