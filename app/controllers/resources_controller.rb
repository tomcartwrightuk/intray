class ResourcesController < ApplicationController
  before_filter :authenticate
  #before_filter :correct_user
	
  def index
    @resource_feed_items = current_user.resource_feed.search(params[:search]).paginate(:page => params[:page])
  end
	
  def create
    error_message = 'Please select a file or copy in a link'
    if params[:resource].params_link?
      @resource = current_user.resources.update_if_present_or_create(params[:resource])
    else
      @resource = current_user.resources.create(params[:resource])
    end

    @resource_feed_items = current_user.resource_feed.search(params[:search]).paginate(:page => params[:page])
    if @resource && params[:resource].params_link?
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
      flash[:success] = "Link saved!" 
    elsif @resource

      respond_to do |format|
        format.html {  
          flash[:success] = "Link saved"
          redirect_to root_path
        }
        format.json {  
          render :json => [@resource.to_jq_upload].to_json			
        }
      end
      flash[:success] = "File saved!" 
    else
      flash[:error] = error_message
      redirect_to root_path
    end
  end
	
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
      filename = resource.upload.url
      redirect_to filename
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
