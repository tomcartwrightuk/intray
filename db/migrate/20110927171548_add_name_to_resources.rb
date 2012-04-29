class AddNameToResources < ActiveRecord::Migration
  def self.up
    add_column :resources, :name, :string
  end

  def self.down
    remove_column :resources, :name, :string
  end
end
