# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161224173733) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "password_reset_digest"
    t.string   "email"
    t.string   "activation_digest"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "registration_tokens",                array: true
  end

  create_table "member_todo_items", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "todo_item_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "member_todo_items", ["member_id"], name: "index_member_todo_items_on_member_id", using: :btree
  add_index "member_todo_items", ["todo_item_id"], name: "index_member_todo_items_on_todo_item_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "members", ["group_id"], name: "index_members_on_group_id", using: :btree

  create_table "todo_items", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "completed",    default: false
    t.integer  "todo_list_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "todo_items", ["todo_list_id"], name: "index_todo_items_on_todo_list_id", using: :btree

  create_table "todo_lists", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "notifications_enabled"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "group_id"
  end

  add_index "todo_lists", ["group_id"], name: "index_todo_lists_on_group_id", using: :btree

  add_foreign_key "member_todo_items", "members"
  add_foreign_key "member_todo_items", "todo_items"
  add_foreign_key "members", "groups"
  add_foreign_key "todo_items", "todo_lists"
  add_foreign_key "todo_lists", "groups"
end
