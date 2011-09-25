require 'spec_helper'

describe SharedItem do
	
	before(:each) do
    @shared_item = Factory(:shared_item)
	end
	
  describe "resource associations" do
		it "should have a resource" do
			@shared_item.should respond_to(:resources)
		end
	end
end