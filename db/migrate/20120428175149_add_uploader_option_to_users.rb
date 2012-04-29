class AddUploaderOptionToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :uploader_option, :boolean
  end

  def self.down
    remove_column :users, :uploader_option
  end
end
