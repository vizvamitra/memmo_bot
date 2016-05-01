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

ActiveRecord::Schema.define(version: 20160501101240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notes", force: :cascade do |t|
    t.text     "text"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notes_on_user_id", using: :btree
  end

  create_table "notes_tags", force: :cascade do |t|
    t.integer "note_id"
    t.integer "tag_id"
    t.index ["note_id"], name: "index_notes_tags_on_note_id", using: :btree
    t.index ["tag_id"], name: "index_notes_tags_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.integer  "telegram_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["telegram_id"], name: "index_users_on_telegram_id", unique: true, using: :btree
  end

  add_foreign_key "notes", "users"
  add_foreign_key "notes_tags", "notes"
  add_foreign_key "notes_tags", "tags"
end
