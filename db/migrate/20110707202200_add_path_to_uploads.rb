class AddPathToUploads < ActiveRecord::Migration
  def self.up
		add_column :uploads, :path, :string
  end

  def self.down
		remove_column :uploads, :path, :string
  end
end
