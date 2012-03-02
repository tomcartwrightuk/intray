module ApplicationHelper
  
  def title
    base_title = "Intray"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
	
  def resource
    resource = Resource.new
  end 
end
