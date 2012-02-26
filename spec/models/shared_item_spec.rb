require 'spec_helper'

describe SharedItem do
  
  before(:each) do
    @sharer = Factory(:user)
    @shared_with = Factory(:user, :email => Factory.next(:email))

    @file = File.open('spec/fixtures/50x50.png')
    @resource = @sharer.resources.build(@file)
    @attr = { :shared_with_id => @shared_with.id, :resource_id => @resource.id }
  end

  it "should create a new instance with valid attributes" do
    @sharer.shared_items.create!(@attr)
  end	

  describe "sharing methods" do
    
    before(:each) do
      @shared_resource = @sharer.shared_items.create!(@attr)
    end

    it "should respond to the sharing user" do
      @shared_resource.should respond_to(:sharer)
    end

    it "should have the right sharing user" do
      @shared_resource.sharer.should == @sharer
    end 
    
    it "should respond to the shared with user" do
      @shared_resource.should respond_to(:shared_with)
    end

    it "should have the right shared with user" do
      @shared_resource.shared_with.should == @shared_with
    end  

  end

  describe "shared item validations" do
      
    it "should require a sharer id" do
      SharedItem.new(@attr).should_not be_valid
    end
    
    it "should require a followed id" do
      @sharer.relationships.build.should_not be_valid
    end
  
  end
	

end
