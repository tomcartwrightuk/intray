class RemoveTypeAddResourceType < ActiveRecord::Migration
  def self.up
		remove_column :resources, :type, :string
		add_column :resources, :resource_type, :string
  end

  def self.down
		add_column :resources, :type, :string
		remove_column :resources, :resource_type, :strin
  end
end
