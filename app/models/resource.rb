require 'file_size_validator'

class Resource < ActiveRecord::Base

  attr_accessible :reference, :upload, :note, :link, :resource_type, :content_type
  belongs_to :user
  mount_uploader :upload, UploadUploader
  before_save :update_upload_attributes, :add_reference, :add_protocol_to_link

  validates :reference, :presence => true, :if => :link?
  validates :upload, :presence => true, :if => :file?,
    :file_size => { :maximum => 40.megabytes } 
  validates :user_id, :presence => true

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

  def update_version_no(record, version)
    #record.update_attributes(:version_no =>  new_ver_no)
    @original = Resource.find_by_id(record)
    @original.version_no = new_ver_no
    @original.save
  end

  include Rails.application.routes.url_helpers
  
  def self.search(search)
    if search
      find(:all, :conditions => ['upload LIKE ? OR link LIKE ?', "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end

  def self.update_if_present_or_create(resource)
    resource.add_protocol_to_link
    result = self.find_by_reference(resource[:reference])
    if result
      result.update_attributes(:updated_at => Time.now)
      return true 
    else new_ref = self.new(resource)
      if new_ref.save
        return true
      else
        return nil
      end
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
	
  def add_protocol_to_link
    if self.resource_type == "link" && self.reference[0..6] != "http://"
      self.reference = "http://" + self.reference
    end
  end

  def add_reference
    if upload.present?
      self.reference = self.upload
    end
  end

end
