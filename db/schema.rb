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

ActiveRecord::Schema.define(version: 20140714144102) do

  create_table "parts", force: true do |t|
    t.integer  "user_id",     null: false
    t.integer  "sick_id",     null: false
    t.integer  "progress_id", null: false
    t.integer  "part",        null: false
    t.integer  "kind",        null: false
    t.integer  "level",       null: false
    t.string   "memo"
    t.integer  "x",           null: false
    t.integer  "y",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parts", ["kind"], name: "index_parts_on_kind", using: :btree
  add_index "parts", ["part"], name: "index_parts_on_part", using: :btree
  add_index "parts", ["progress_id"], name: "index_parts_on_progress_id", using: :btree
  add_index "parts", ["sick_id"], name: "index_parts_on_sick_id", using: :btree
  add_index "parts", ["user_id", "sick_id", "kind"], name: "index_parts_on_user_id_and_sick_id_and_kind", using: :btree
  add_index "parts", ["user_id", "sick_id", "part"], name: "index_parts_on_user_id_and_sick_id_and_part", using: :btree
  add_index "parts", ["user_id", "sick_id", "progress_id"], name: "index_parts_on_user_id_and_sick_id_and_progress_id", using: :btree
  add_index "parts", ["user_id"], name: "index_parts_on_user_id", using: :btree

  create_table "progresses", force: true do |t|
    t.integer  "user_id",     null: false
    t.integer  "sick_id",     null: false
    t.datetime "progress_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "progresses", ["sick_id", "user_id"], name: "index_progresses_on_sick_id_and_user_id", using: :btree
  add_index "progresses", ["sick_id"], name: "index_progresses_on_sick_id", using: :btree
  add_index "progresses", ["user_id", "sick_id"], name: "index_progresses_on_user_id_and_sick_id", using: :btree
  add_index "progresses", ["user_id"], name: "index_progresses_on_user_id", using: :btree

  create_table "sick_comments", force: true do |t|
    t.integer  "comment_by_user_id"
    t.integer  "sick_id"
    t.integer  "user_id"
    t.integer  "is_owner_comment"
    t.string   "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sick_comments", ["sick_id", "user_id"], name: "index_sick_comments_on_sick_id_and_user_id", using: :btree
  add_index "sick_comments", ["user_id", "sick_id"], name: "index_sick_comments_on_user_id_and_sick_id", using: :btree

  create_table "sicks", force: true do |t|
    t.integer  "owner_id"
    t.integer  "status",                     null: false
    t.string   "recover_completely_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sicks", ["owner_id"], name: "index_sicks_on_owner_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "nickname",   null: false
    t.string   "image_url",  null: false
    t.string   "sex"
    t.datetime "birth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree

end
