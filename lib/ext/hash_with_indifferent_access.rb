class HashWithIndifferentAccess 
  
  def params_link?
    self[:resource_type] == 'link'
  end

  
  def add_protocol_to_link
    if self[:reference][1] && self[:reference][0..6] != "http://"
      self[:reference] = "http://" + self[:reference] 
    end
  end

end
    
