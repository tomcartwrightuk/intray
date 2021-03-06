class UsersController < ApplicationController

  respond_to :html, :xml, :json, :js  

  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @user_to_follow = @user
    respond_with(@user) do |format|
      format.js  { render :json => @user, :callback => params[:callback] }
    end
  end

  def index
    @title = "Intray users"
    @users = User.search(params[:search]).paginate(:page => params[:page])
    @user = current_user
    respond_to do |format|
      format.html
      format.xml { render :xml => @users }
      format.json { render :json => @users }
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  def new
    @title = "Sign up"
    @user = Users.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save 
      sign_in @user
      redirect_to root_path, :flash => { :success => "Welcome to the Intray!" }
    else
      @title = "Sign up"
      flash[:error] = "Check the sign-up code - is it correct?"
      render 'pages/home'
    end
  end
  
  def edit
    @title = "Edit profile"
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => { :success => "Your profile was updated!" }
    else
      @title = "Edit profile"
      render 'edit'
    end
  end
	  
  def following
    @title = "Colleagues you have connected with"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Collegues who have connected with you"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  def uploader_toggle
    current_user.toggle!(:uploader_option)
    redirect_to root_path
  end
	
	
  
  private
	
  def admin_user
    @user = User.find(params[:id])
    redirect_to(root_path) if !current_user.admin? || current_user?(@user)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user == @user
  end
    
end
