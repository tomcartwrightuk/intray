class AddVersionNoToResources < ActiveRecord::Migration
  def self.up
    add_column :resources, :version_no, :integer
  end

  def self.down
    remove_column :resources, :version_no, :integer
  end
end
