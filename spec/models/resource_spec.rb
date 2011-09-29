require 'spec_helper'

describe Resource do

	before(:each) do
		@user = Factory(:user)
    UploadUploader.enable_processing = true
    @uploader = @user.resources.build(:upload)
    @file = @uploader.save
  end

	after do
    UploadUploader.enable_processing = false
  end

  describe "resource associations" do
		it "should have a user" do
			@uploader.should respond_to(:user)
		end
	end
end
