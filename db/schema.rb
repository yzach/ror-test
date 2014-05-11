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

ActiveRecord::Schema.define(version: 20140504092026) do

  create_table "edits", force: true do |t|
    t.integer  "translation_id"
    t.integer  "user_id"
    t.string   "status",         default: "new"
    t.text     "original_text"
    t.text     "suggested_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "edits", ["status"], name: "index_edits_on_status"
  add_index "edits", ["translation_id"], name: "index_edits_on_translation_id"
  add_index "edits", ["user_id"], name: "index_edits_on_user_id"

  create_table "languages", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stories", ["user_id"], name: "index_stories_on_user_id"

  create_table "story_translations", force: true do |t|
    t.integer  "story_id"
    t.string   "title"
    t.text     "text"
    t.integer  "language_id"
    t.boolean  "auto_translated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "story_translations", ["auto_translated"], name: "index_story_translations_on_auto_translated"
  add_index "story_translations", ["language_id"], name: "index_story_translations_on_language_id"
  add_index "story_translations", ["story_id"], name: "index_story_translations_on_story_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   default: "user"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
