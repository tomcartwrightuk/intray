class AddFileSizeContentTypeToResources < ActiveRecord::Migration
  def self.up
		add_column :resources, :content_type, :string
		add_column :resources, :file_size, :integer
  end

  def self.down
		remove_column :resources, :content_type, :string
		remove_column :resources, :file_size, :integer
  end
end
