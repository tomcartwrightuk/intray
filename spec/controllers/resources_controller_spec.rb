require 'spec_helper'
require 'carrierwave/test/matchers'


describe ResourcesController do
  include CarrierWave::Test::Matchers

  describe "POST create" do
        
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "fail to create" do
      
      before(:each) do
        @link = { :reference => "", :resource_type => "link" }
      end
        
      it "should not create a new resource" do
        lambda do
          post :create, :resource => @link  
        end.should_not change(Resource, :count)
      end
    end

    describe "create success" do
      
      before(:each) do
        @link = { :reference => "example.com", :resource_type => "link" }
      end

      it "should create a new resource" do
        lambda do
          post :create, :resource => @link  
        end.should change(Resource, :count)
      end

      it "should redirect to the root path" do
        post :create, :resource => @link  
        response.should redirect_to(root_path)
      end

      it "should have a flash success message" do
        post :create, :resource => @link  
        flash[:success].should =~ /Link saved/i
      end

      it "should create a link resource using Ajax" do
        lambda do
          xhr :post, :create, :resource => @link
          response.should be_success
        end.should change(Resource, :count).by(1)
      end


    end

  end
    
  describe "downloads" do

    after do
      UploadUploader.enable_processing = false
    end

    describe "unauthenticated downloads" do

      before do
        @user = Factory(:user)
        @resource = Factory(:upload, :user => @user)
        @second_user = test_sign_in(Factory(:user, :email => Factory.next(:email)))
      end

      after do
        UploadUploader.enable_processing = false
      end

      it "should not allow access to the file" do
        get :download, :id => @resource 
        response.should redirect_to '/signin'
      end

    end

    describe "authenticated uploads and downloads" do
      before do
        @user = test_sign_in(Factory(:user))
        @resource = Factory(:upload, :user => @user)
      end

      after do
        UploadUploader.enable_processing = false
      end

      it "should create an accessible file" do
        get :download, :id => @resource.id
        response.should redirect_to @resource.upload.url
      end
    end
  end

  describe "file renaming" do
  end

    



end
