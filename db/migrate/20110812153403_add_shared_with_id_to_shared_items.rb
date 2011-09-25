class AddSharedWithIdToSharedItems < ActiveRecord::Migration
  def self.up
		add_column :shared_items, :shared_with_id, :integer
		add_column :shared_items, :shared_with_type, :string
		remove_column :shared_items, :sharable_id, :integer
		remove_column :shared_items, :sharable_type, :string
  end

  def self.down
		remove_column :shared_items, :shared_with_id, :integer
		remove_column :shared_items, :shared_with_type, :string
		add_column :shared_items, :sharable_id, :integer
		add_column :shared_items, :sharable_type, :string
  end
end
