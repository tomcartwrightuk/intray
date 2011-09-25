class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
	
	def side_bar
		@resource = Resource.new
	end
	
end
