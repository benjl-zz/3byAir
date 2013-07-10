class TwilioController < ApplicationController

	 around_filter :shopify_session, :except => 'welcome' 

	def process_sms
		@products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
		@city = params[:FromCity].capitalize
    	@state = params[:FromState]
		render 'process_sms.xml.erb', :content_type => 'text/xml'
	end
end
