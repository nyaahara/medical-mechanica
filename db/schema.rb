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

ActiveRecord::Schema.define(version: 20140628145611) do

  create_table "symptom_details", force: true do |t|
    t.integer  "owner_id",          null: false
    t.integer  "symptom_id",        null: false
    t.integer  "symptom_detail_id"
    t.integer  "part",              null: false
    t.integer  "kind",              null: false
    t.integer  "level",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "symptoms", force: true do |t|
    t.integer  "owner_id",      null: false
    t.integer  "symptom_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "time_symptoms"
  end

  add_index "symptoms", ["owner_id", "symptom_id"], name: "index_symptoms_on_owner_id_and_symptom_id", unique: true, using: :btree

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
