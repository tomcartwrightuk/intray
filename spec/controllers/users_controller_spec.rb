require 'spec_helper'

describe UsersController do

  
  render_views
    
  describe "GET 'index'" do
    
    describe "for non-signed in users" do
      it "should deny access and redirect to the user signin pages" do
        get :index
        response.should redirect_to(signin_path)      
      end
    end
    
    describe "for signed-in users" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        second = Factory(:user, :name => "Bob", :email => "another@example.com")
        third  = Factory(:user, :name => "Ben", :email => "another@example.net")

        @users = [@user, second, third]
        30.times do
          @users << Factory(:user, :email => Factory.next(:email))
        end
      end
    

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "Intray users")
      end

#       it "should have an element for each user" do
#         get :index
#         @users.each do |user|
#           response.should have_selector("li", :content => user.name)
#         end
#       end
      
      it "should have an element for each user" do
        get :index
        @users[0..2].each do |user|
          response.should have_selector("td", :content => user.name)
        end
      end

      it "should paginate users" do
        get :index
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/users?page=2", :content => "2")
        response.should have_selector("a", :href => "/users?page=2", :content => "Next")
      end
    end
    
  end
  
      
                  
  describe "GET 'new'" do
    
#     it "shoud be successful" do
#       get 'pages/home'
#       response.should be_successful
#     end
    
#     it "should have the right title" do
#       get ''
#       response.should have_selector("title", :content => "Sign up")
#     end
   
  end
  
  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user) 
    end

    it "should be successful" do
      get :show, :id => @user # rails is calling .id on the @user object - get :show is the same as get 'show'
      response.should be_success
    end
    
    it "should find the right user" do
			get :show, :id => @user
			assigns(:user).should == @user
    end
    
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end
    
    it "should have the User's name in a title" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end
    
    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector('img', :class => "gravatar")
    end
		
		
  end
    
  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

#       it "should have the right title" do
#         post :create, :user => @attr
#         response.should have_selector("title", :content => "Circl")
#       end

      it "should render the home page" do
        post :create, :user => @attr
        response.should render_template('pages/home')
      end
    end

    
      
    describe "success" do
       
    before(:each) do
        @attr = { :name => "Example User", :email => "me@me.com", :password => "foobar",
                  :password_confirmation => "foobar", :sign_up_code => "henry" }
    end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

#       it "should have the right title" do
#         post :create, :user => @attr
#         response.should have_selector("title", :content => @user[:name])
#       end

      it "should redirect to the users page" do
        post :create, :user => @attr
        response.should redirect_to root_path
      end
      
      it "should sign the user in" do
	post :create, :user => @attr
	:sign_in.should be_true
      end
      
    end  
  end
  
  describe "GET 'edit'" do
    
    before(:each) do 
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    it "should be successful" do 
      get :edit, :id => @user
      response.should be_success
    end
    
    it "should have the right title" do
     get :edit, :id => @user
     response.should have_selector("title", :content => "Edit profile")
    end
  end
  
  describe "PUT 'update'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
        
    describe "failure" do
      
      before(:each) do
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end
      
      it "should render the edit page" do
	put :update, :id => @user, :user => @attr
	response.should render_template('edit')
      end
      
      it "should have the right title" do
	put :update, :id => @user, :user => @attr
	response.should have_selector("title", :content => "Edit")
      end
      
    end

    describe "success" do
      
      before(:each) do
        @attr = { :name => "New Name", :email => "new@email.com", :password => "azsxdc",
                  :password_confirmation => "azsxdc" }
      end
      
      it "should change the users atrributes" do
				put :update, :id => @user, :user => @attr
				user = assigns(:user)
				@user.reload
				@user.name.should == user.name
				@user.email.should == user.email
				@user.encrypted_password.should == user.encrypted_password
      end
      
      it "should render the profile page" do
	put :update, :id => @user, :user => @attr
	response.should redirect_to @user
      end
      
      it "should have a flash message" do
	put :update, :id => @user, :user => @attr
	flash[:success].should =~ /updated/
      end
      
    end
    
  end
  
  describe "authentication of edit/update pages" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {} #here I can 
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in users" do

      before(:each) do
        wrong_user = Factory(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end

      it "should require matching users for 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end

      it "should require matching users for 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end
      
    end
  end
	
  describe "DELETE 'destroy'" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @user
        response.should redirect_to(signin_path)
      end
    end

#     describe "as a non-admin user" do
#       it "should protect the page" do
#         test_sign_in(@user)
#         delete :destroy, :id => @user
#         response.should redirect_to(root_path)
#       end
#     end
		
    describe "as non-admin user" do
      it "should protect the action" do
        test_sign_in(@user)
        delete :destroy, :id => @user
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end

      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end

      it "should redirect to the users page" do
        delete :destroy, :id => @user
        response.should redirect_to(users_path)
      end
    end
  end
	
  describe "follow pages" do

    describe "when not signed in" do

      it "should protect 'following'" do
        get :following, :id => 1
        response.should redirect_to(signin_path)
      end

      it "should protect 'followers'" do
        get :followers, :id => 1
        response.should redirect_to(signin_path)
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @other_user = Factory(:user, :email => Factory.next(:email))
        @user.follow!(@other_user)
      end

      it "should show user following" do
        get :following, :id => @user
        response.should have_selector("a", :href => user_path(@other_user),
                                           :content => @other_user.name)
      end

      it "should show user followers" do
        get :followers, :id => @other_user
        response.should have_selector("a", :href => user_path(@user),
                                           :content => @user.name)
      end
    end
  end
  
  describe "uploader_pref" do
    
    it "should toggle the pref off" do
    end
    
    it "should togggle the pref on" do
    end

  end
end
