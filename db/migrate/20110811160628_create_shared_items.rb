class CreateSharedItems < ActiveRecord::Migration
  def self.up
    create_table :shared_items do |t|
      t.integer :user_id
      t.integer :sharable_id
      t.string :sharable_type
      t.integer :resource_id
      t.string :resource_type

      t.timestamps
    end
  end

  def self.down
    drop_table :shared_items
  end
end
