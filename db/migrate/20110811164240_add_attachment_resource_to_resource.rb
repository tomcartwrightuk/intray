class AddAttachmentResourceToResource < ActiveRecord::Migration
  def self.up
		add_column :resources, :user_id, :integer
    add_column :resources, :resource_file_name, :string
    add_column :resources, :resource_content_type, :string
    add_column :resources, :resource_file_size, :integer
    add_column :resources, :resource_updated_at, :datetime
  end

  def self.down
		remove_column :resources, :user_id
    remove_column :resources, :resource_file_name
    remove_column :resources, :resource_content_type
    remove_column :resources, :resource_file_size
    remove_column :resources, :resource_updated_at
  end
end
