class AddLinkToResources < ActiveRecord::Migration
  def self.up
		add_column :resources, :link, :string
  end

  def self.down
		remove_column :resources, :link, :string
  end
end
