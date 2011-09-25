class AddSignUpCodeToUser < ActiveRecord::Migration
  def self.up
		add_column :users, :sign_up_code, :string
	end
	
  def self.down
		remove_column :users, :sign_up_code, :string
  end
end
