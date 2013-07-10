class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
  end
  
  def index
    # get 10 products
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})

    # get latest 5 orders
    @orders   = ShopifyAPI::Order.find(:all, :params => {:limit => 5, :order => "created_at DESC" })
  end

  def receive_text_message
    #get 10 latest products

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

      @twilio_client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => number_to_send_to,
        :body => "hello"
      )

      respond_to do |format|
        format.xml
      end
  end
  
end