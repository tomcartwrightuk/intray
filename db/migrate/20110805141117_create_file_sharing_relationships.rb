class CreateFileSharingRelationships < ActiveRecord::Migration
  def self.up
    create_table :file_sharing_relationships do |t|
      t.integer :sharer_id
      t.integer :upload_id
      t.integer :shared_with_id

      t.timestamps
    end
    
    add_index :file_sharing_relationships, :sharer_id
    add_index :file_sharing_relationships, :upload_id
    add_index :file_sharing_relationships, :shared_with_id
#     add_index :file_sharing_relationships, [:sharer_id, :shared_with_id], :unique => true
  end

  def self.down
    drop_table :file_sharing_relationships
  end
 
end
