class AddDescriptionToUploads < ActiveRecord::Migration
  def self.up
		add_column :uploads, :decription, :string
		add_column :uploads, :tags, :string
		add_index :uploads, :tags
  end

  def self.down
		remove_column :uploads, :decription, :string
  end
end
