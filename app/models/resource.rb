require 'file_size_validator'

class Resource < ActiveRecord::Base
  belongs_to :user
  mount_uploader :upload, UploadUploader
  before_save :update_upload_attributes, :add_reference, :add_protocol_to_link

  validates :reference, :presence => true, :if => :link?
  validates :upload, :presence => true, :if => :file?,
    :file_size => { :maximum => 40.megabytes } 

  has_many :shared_items, :dependent => :destroy
  
  def self.uploads_list
    where(:link => nil)
  end
  
  def self.links_list
    where(:upload => nil)
  end
  
  def self.shared_resources(user)
    where("resources.user_id != ?", user)
  end
  
  def shared_with?(user_id)
    shared_items.find_by_shared_with_id(user_id)
  end

  def link?
    resource_type == "link"
  end
  
  def file?
    resource_type == "file"
  end
  
  include Rails.application.routes.url_helpers
  
  def self.search(search)
    if search
      find(:all, :conditions => ['upload LIKE ? OR link LIKE ?', "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end

  def self.update_if_present_or_create(reference)
    reference = reference.add_protocol_to_link
    result = self.find_by_reference(reference)
    new_ref = self.new(:reference => reference, :resource_type => 'link')
    if result
      result.update_attributes(:updated_at => Time.now)
      return true 
    elsif new_ref.save
      return true
    else
      return nil
    end
  end
	
  def shared_item(user)
    shared_items.find_by_shared_with_id(user)
  end	
	
  def to_jq_upload
    {
    "name" => read_attribute(:upload),
    "size" => upload.size,
    "url" => upload.url,
    "delete_url" => resource_path(:id => id),
    "delete_type" => "DELETE" 
    }
  end	
	
    scope :from_users_sharing_with, lambda { |user| 
    includes(:shared_items).
    where("shared_items.shared_with_id = ? OR resources.user_id = ?", user.id, user.id).
    order("shared_items.updated_at DESC, resources.updated_at DESC")
    }
	
  private
	
  def update_upload_attributes
    if upload.present? && upload_changed?
      self.content_type = upload.file.content_type
      self.file_size = upload.file.size
    end
  end
	
  def add_reference
    if upload.present?
      self.reference = self.upload
    end
  end
	
  def add_protocol_to_link
    if self.resource_type == "link" && self.reference[0..6] != "http://"
      self.reference = "http://" + self.reference
    end
  end

end
