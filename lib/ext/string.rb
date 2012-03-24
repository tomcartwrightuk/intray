class String
  
  def add_protocol_to_link
    if self[0] && self[0..6] != "http://"
      return "http://" + self
    else
      return self
    end
  end

end
