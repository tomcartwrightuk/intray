require 'spec_helper'
require 'carrierwave/test/matchers'


describe ResourcesController do
  include CarrierWave::Test::Matchers

  #before do
    #@user = Factory(:user)
    #@file = File.open('spec/fixtures/50x50.png')
    #@resource = Resource.new(@user)
    #@resource.store!(File.open('spec/fixtures/50x50.png'))
  #end
  before(:each) do
    #@user = Factory(:user)
    #@file = File.open('spec/fixtures/50x50.png')
    #@file_resource = @user.resources.build(@file)
    #@link = { :link => "http://example.com" }
    #@resource = @user.resources.build(@link)
    #@uploaded = @resource.save
  end

  describe "POST create" do
        
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "fail to create" do
      
      before(:each) do
        @link = { :link => "" }
      end
        
      it "should not create a new resource" do
        lambda do
          post :create, :resource => @link  
        end.should_not change(Resource, :count)
      end
    end

    describe "create success" do
      it "should add a protocol to a link with no protocol" do
      end
    end

  end
    
  describe "downloads" do
    describe "unauthenticated downloads" do

      it "should not allow access to the file" do
        get :download, :id =>  @file_resource.id
        response.should redirect_to '/signin'
      end

    end

    describe "authenticated uploads and downloads" do
      before do
        @user = test_sign_in(Factory(:user, :email => Factory.next(:email)))
      end

      after do
        UploadUploader.enable_processing = false
      end

      it "should create an accessible file" do
        get :download, :id => @file_resource 
        response.should redirect_to @file_resource.upload.url
      end
    end
  end



end
