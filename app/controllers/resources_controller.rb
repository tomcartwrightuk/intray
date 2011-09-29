class ResourcesController < ApplicationController
#   before_filter :authenticate
# 	before_filter :correct_user
	
  def index
		@title = "Your files"
		@users_resources = current_user.resources
		@resource_allowance_used = current_user.allowance_used(@users_resources)
    @resources = current_user.resources.search(params[:search]).paginate(:page => params[:page])
		@shared_items = current_user.shared_with_resources
		@resources_uploads = current_user.resources.uploads_list.paginate(:page => params[:page])
		@resource_feed_items = current_user.resource_feed.search(params[:search]).paginate(:page => params[:page])
# 		@user.update_attributes
	end
	
	def files
		@title = "Your files"
		@resource = Resource.new
    @resources = current_user.resources.uploads_list.search(params[:search]).paginate(:page => params[:page])	
		render 'resources/index_temp'
	end
	
	def links
		@resource = Resource.new 
		@title = "Links"
		@resources = current_user.resources.links_list.paginate(:page => params[:page])
		render 'resources/index_temp'
	end
	
	def shared_files
		@title = "Shared files"
		@resource = Resource.new
		@resources = current_user.resource_feed.shared_resources(current_user).uploads_list.search(params[:search]).paginate(:page => params[:page])
		render 'resources/index_temp'
	end
	
	def shared_links
		@title = "Shared links"
		@resource = Resource.new
		@resources = current_user.resource_feed.shared_resources(current_user).links_list.search(params[:search]).paginate(:page => params[:page])
		render 'resources/index_temp'
	end
	
  def create
		@resource = current_user.resources.build(params[:resource])

    if params[:resource] == nil || params[:resource][:link] == ""
      @user = current_user
			flash[:error] = "Please select a file to upload or copy in a link."
      redirect_to root_path
		else
			@resource.save
			if params[:resource][:link]
				flash[:success] = "Link saved"
			else
				flash[:success] = "File uploaded"
			end
      redirect_to root_path
    end
  end
	
# 	def create
#     @resource = current_user.resources.build(params[:resource])
#     if @resource.save
#       render :json => [ @resource.to_jq_upload ].to_json
#     else 
#       render :json => [ @resource.to_jq_upload.merge({ :error => "custom_failure" }) ].to_json
#     end
#   end
	
# 		def create
#     
#     if params[:resource][:link] != nil 
# 			@resource = current_user.resources.new
# 			@resource.link = params[:resource][:link]
# 			@resource.save
#       redirect_to root_path
#     else 
# 			@resource = current_user.resources.build(params[:resource])
# 			@resource.save
#       render :json => [ @resource.to_jq_upload ].to_json
#     end
#   end
	
# 	def create
#     @resource = current_user.resources.build(params[:resource])
#     if params[:resource][:link] != nil 
# 			@resource.save
#       redirect_to resources_path
#     else 
# 			store!(@resource)
#       render :json => [ @resource.to_jq_upload ].to_json
#     end
#   end
	
#   def destroy
#     Resource.find(params[:id]).destroy
#     flash[:success] = "File deleted."
#     redirect_to resources_path
#   end
	
	def destroy
		@resource = Resource.find(params[:id]).destroy.remove_upload!
		flash[:success] = "File deleted."
    redirect_to root_path
	end
	

	def show
		@users = current_user.following.paginate(:page => params[:page])
		@resource = Resource.find(params[:id])
		@shared_item = SharedItem.new
		@resource_id = params[:id]
	end
	
	def download
    if resource = Resource.find(params[:id])
			if resource.shared_items.find_by_shared_with_id(current_user) or resource.user_id == current_user.id
	# 		filename = "#{File.basename(resource.upload_url.to_s)}"
			filename = resource.upload.url
			redirect_to filename
	# 		uploader = UploadUploader.new
	# 		uploader.retrieve_from_store!(resource)
	# 		send_file uploader.file.path
			else
			flash[:notice] = "You don't have permission to access this file."
			redirect_to root_path
			end
		else
			flash[:notice] = "Woops - This file doesn't seem to exist anymore."
			redirect_to root_path
		end
	end
	
	def edit
		@title = "Rename file"
		@resource = Resource.find(params[:id])
	end
	
	def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(params[:resource])
      redirect_to @resource
    else
      redirect_to @resource, :flash => { :error => "There was an error adding a note- try again" }
    end
  end
	

	
end