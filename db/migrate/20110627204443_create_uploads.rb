class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
		t.timestamps
    end
		add_column :uploads, :uploaded_file_name,    :string
    add_column :uploads, :uploaded_content_type, :string
    add_column :uploads, :uploaded_file_size,    :integer
    add_column :uploads, :uploaded_updated_at,   :datetime
  end

  def self.down
    drop_table :uploads
  end
end

