class AddSharedTimesResources < ActiveRecord::Migration
  def self.up
		add_column :resources, :shared_count, :integer
  end

  def self.down
		remove_column :resources, :shared_count, :integer
  end
end
