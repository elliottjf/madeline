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

ActiveRecord::Schema.define(version: 20160103040147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "divisions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loans", force: true do |t|
    t.string   "name"
    t.decimal  "amount",        precision: 12, scale: 2
    t.decimal  "rate",          precision: 8,  scale: 4
    t.integer  "length_months"
    t.integer  "division_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loans", ["division_id"], name: "index_loans_on_division_id", using: :btree

  create_table "translations", force: true do |t|
    t.integer  "translatable_id"
    t.string   "translatable_type"
    t.string   "translatable_attribute"
    t.integer  "language_id"
    t.text     "text"
    t.boolean  "is_primary"
    t.boolean  "is_dirty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "translations", ["language_id"], name: "index_translations_on_language_id", using: :btree
  add_index "translations", ["translatable_id", "translatable_type"], name: "index_translations_on_translatable_id_and_translatable_type", using: :btree

end
