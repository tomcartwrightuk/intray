require 'spec_helper'

describe "LayoutLinks" do
  describe "GET /layout_links" do
   
    it "should have a Home page at '/'" do
      get '/'
      response.should have_selector('title', :content => "Intray")
    end
    
    it "should have a Contact page at '/contact'" do
      get '/contact'
      response.should have_selector('title', :content => "Contact")
    end

    it "should have an About page at '/about'" do
      get '/about'
      response.should have_selector('title', :content => "About")
    end
  
  end
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should have_selector('title', :content => "Intray")
#     click_link "Sign up now!"
#     response.should # fill in
  end
  
  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("input", :id => "session_email")
    end
  end

  describe "when signed in" do

    before(:each) do
      @user = Factory(:user)
      visit root_path
      fill_in :session_email,    :with => @user.email
      fill_in :session_password, :with => @user.password
      click_button
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path,
                                         :content => "Sign out")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                         :content => "Profile")
    end
    
    
  end
end
