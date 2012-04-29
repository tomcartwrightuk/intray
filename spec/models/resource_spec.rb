require 'spec_helper'
require 'carrierwave/test/matchers'

describe Resource do

  before(:each) do
    @user = Factory(:user)
    @link = { :link => 'http://example.com' }
    @uploader = @user.resources.build(:upload)
    @file = @uploader.save
  end

  describe "resource associations" do

    it "should have a user" do
      @uploader.should respond_to(:user)
    end

  end

  describe "validations" do
    it "should have a user id" do
      Resource.new(@link).should_not be_valid
    end

    it "should require a reference" do
      @user.resources.build(:link => '', :resource_type => 'link').should_not be_valid
    end
  end

  describe "resource version control" do

    before do
      @resource = Factory(:upload, :user => @user)
      @resource_ver2 = Factory(:upload, :user => @user)
    end

    after do
      UploadUploader.enable_processing = false
    end

    it "should add a version number to duplicated files" do
      @resource_ver2.upload.should == 'file_ver2.png'
    end
  end

  describe "shared resources" do

    describe "from_users_sharing_with" do
      
      before(:each) do
        @second_user = Factory(:user, :email => Factory.next(:email))
        @third_user = Factory(:user, :email => Factory.next(:email))
        
        @user_resource = @user.resources.build(@link)
        @second_resource = @third_user.resources.build(:link => "http://third_user_url.com")
        @user.follow!(@second_user)
        @shared_item = @user.shared_items.build(:resource_id => @user_resource.id, :shared_with_id => @second_user.id)
        
      end

      it "should have a from_users_sharing_with method" do
        Resource.should respond_to(:from_users_sharing_with)
      end    
      
      it "a resource shared with a user should respond to it's owner" do
        Resource.from_users_sharing_with(@second_user).should include(@user_resource)
      end
      
      it "should include the user's own resource" do
        Resource.from_users_sharing_with(@user).should include(@user_resource)
      end
      
      it "should not include an unshared resource" do
        Resource.from_users_sharing_with(@user).should_not include(@second_resource)
      end
    end
  
  end

end
