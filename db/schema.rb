# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111108181625) do

  create_table "file_sharing_relationships", :force => true do |t|
    t.integer  "sharer_id"
    t.integer  "upload_id"
    t.integer  "shared_with_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "file_sharing_relationships", ["shared_with_id"], :name => "index_file_sharing_relationships_on_shared_with_id"
  add_index "file_sharing_relationships", ["sharer_id"], :name => "index_file_sharing_relationships_on_sharer_id"
  add_index "file_sharing_relationships", ["upload_id"], :name => "index_file_sharing_relationships_on_upload_id"

  create_table "products", :force => true do |t|
    t.string   "reference"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "resources", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "upload"
    t.string   "note"
    t.integer  "shared_count"
    t.string   "link"
    t.string   "content_type"
    t.integer  "file_size"
    t.string   "reference"
    t.string   "resource_type"
  end

  create_table "shared_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shared_with_id"
    t.string   "shared_with_type"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.integer  "storage_allowance",  :default => 524288000
    t.integer  "storage_used",       :default => 0
    t.string   "sign_up_code"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
