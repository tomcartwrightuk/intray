require 'spec_helper'
require 'carrierwave/test/matchers'


describe UploadUploader do
  include CarrierWave::Test::Matchers

  before do
    @resource = Resource.new
    UploadUploader.enable_processing = true
    @uploader = UploadUploader.new(@resource, :upload)
    @uploader.store!(File.open('spec/fixtures/50x50.png'))
  end

  after do
    UploadUploader.enable_processing = false
    @uploader.remove!
  end

  it "should create a file" do
    @uploader.should be_true
  end
	
end

