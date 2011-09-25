class AddStorageAllowanceToUser < ActiveRecord::Migration
  def self.up
		add_column :users, :storage_allowance, :integer, :default => 524288000
		add_column :users, :storage_used, :integer, :default => 0
  end

  def self.down
		remove_column :users, :storage_allowance
		remove_column :users, :storage_used
  end
end
