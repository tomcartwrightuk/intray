class AddMessageToResources < ActiveRecord::Migration
  def self.up
		add_column :resources, :note, :string
  end

  def self.down
		remove_column :resources, :note, :string
  end
end
