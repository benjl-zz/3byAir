class TwilioController < ApplicationController
	
	around_filter :shopify_session, :except => 'welcome'
  
	def welcome
	current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
	@callback_url = "http://#{current_host}"
	end

	def process_sms
		@products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
		@city = params[:FromCity].capitalize
    	@state = params[:FromState]
		render 'process_sms.xml.erb', :content_type => 'text/xml'
	end
end
