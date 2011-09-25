class PagesController < ApplicationController
  
  def home
		@title = "Home"
#     @user = User.new
		if signed_in?
			@user = current_user
			@resource = Resource.new(params[:resource])
# 			@feed_items = current_user.feed.paginate(:page => params[:page])
			@resource_feed_items = current_user.resource_feed.search(params[:search]).paginate(:page => params[:page])
			@users_resources = current_user.resources
			@resource_allowance_used = current_user.allowance_used(@users_resources)
# 			@uploader = UploadUploader.new
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
