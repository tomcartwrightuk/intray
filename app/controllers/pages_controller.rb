class PagesController < ApplicationController
  
  def home
    @title = "Home"
    if signed_in?
      @user = current_user
      @resource = Resource.new(params[:resource])
      @resource_feed_items = current_user.resource_feed.search(params[:search]).paginate(:page => params[:page])
      @users_resources = current_user.resources
      @resource_allowance_used = current_user.allowance_used(@users_resources)
    else
    @user = User.new
    end
		
  end
	
  def contact
    @user = User.new
    @title = "Contact"
  end

  def about
		@user = User.new
    @title = "About"
  end
      
end
