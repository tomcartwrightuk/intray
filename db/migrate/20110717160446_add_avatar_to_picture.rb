class AddAvatarToPicture < ActiveRecord::Migration
  def self.up
		add_column :pictures, :avatar, :string
  end

  def self.down
		remove_column :pictures, :avatar, :string
  end
end
