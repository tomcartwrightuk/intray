class RelationshipsController < ApplicationController
  before_filter :authenticate

  def create
    @user = User.find(params[:relationship][:followed_id])
		if current_user.follow!(@user)
			 redirect_to users_path
		else
			flash[:error] = "There has been an error - try again"
			redirect_to users_path
		end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js
    end
  end
end
