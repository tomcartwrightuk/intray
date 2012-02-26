require 'spec_helper'
require 'carrierwave/test/matchers'


describe ResourcesController do
  include CarrierWave::Test::Matchers

  before do
    @user = Factory(:user)
    @file = File.open('spec/fixtures/50x50.png')
    @resource = @user.resources.build(@file)
    @uploaded = @resource.save
  end

  after do
    UploadUploader.enable_processing = false
  end

  it "should make the image readable only to the owner and not executable" do
    @uploaded.should have_permissions(0600)
  end
	
  it "should create a resource that belongs to the user" do
    @resource.user_id.should == @user.id
  end
end
