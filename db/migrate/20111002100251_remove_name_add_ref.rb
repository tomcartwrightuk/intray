class RemoveNameAddRef < ActiveRecord::Migration
  def self.up
		remove_column :resources, :name, :string
		add_column :resources, :reference, :string
		add_column :resources, :type, :string
  end

  def self.down
		add_column :resources, :name, :string
		remove_column :resources, :reference, :string
		remove_column :resources, :type, :string
  end
end
