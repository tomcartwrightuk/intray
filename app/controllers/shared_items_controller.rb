class SharedItemsController < ApplicationController
	
	before_filter :authenticate

  def create
    @users = current_user.following
    @shared_item = SharedItem.new(params[:shared_item])
    @resource = Resource.find_by_id(params[:shared_item][:resource_id])
    if @shared_item.save
      redirect_to @resource
    else
      flash[:error] = "There has been an error - try again"
      redirect_to @resource
    end
  end
	

  def destroy
		@users = current_user.following
		@resource = Resource.find_by_id(params[:shared_item][:resource_id])
    SharedItem.find(params[:id]).destroy
		redirect_to @resource

	end
	
end
