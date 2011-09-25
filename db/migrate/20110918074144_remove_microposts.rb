class RemoveMicroposts < ActiveRecord::Migration
  def self.up
		drop_table :microposts
		drop_table :pictures
		drop_table :uploads
  end

  def self.down
		create_table :microposts
		create_table :pictures
		create_table :uploads
  end
end
