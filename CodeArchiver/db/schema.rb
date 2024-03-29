# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100520134400) do

  create_table "admin_logs", :force => true do |t|
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "aid"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "code_replies", :force => true do |t|
    t.integer  "child_id"
    t.integer  "code_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "codes", :force => true do |t|
    t.string   "title"
    t.text     "code_body"
    t.string   "tag"
    t.text     "description"
    t.text     "shortdescription"
    t.integer  "user_id"
    t.integer  "program_language_id"
    t.integer  "category_id"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private"
    t.integer  "views"
    t.float    "popularity"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "code_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", :force => true do |t|
    t.integer  "value",      :limit => 10, :precision => 10, :scale => 0
    t.integer  "user_id"
    t.integer  "code_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string   "email"
    t.string   "IM"
    t.string   "company"
    t.text     "portfolio"
    t.string   "webpage"
    t.string   "avatar"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "listing"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
  end

  create_table "program_languages", :force => true do |t|
    t.string   "language_name"
    t.text     "reservered_words"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "syntax_tag"
  end

  create_table "subcategories", :force => true do |t|
    t.integer  "child_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group"
  end

end
