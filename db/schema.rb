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

ActiveRecord::Schema.define(version: 20160103104455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "default_language_id"
    t.integer  "default_currency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: true do |t|
    t.string   "name"
    t.string   "symbol"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "divisions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.integer  "default_currency_id"
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
    t.integer  "division_id"
    t.integer  "organization_id"
    t.string   "name"
    t.integer  "primary_agent_id"
    t.integer  "secondary_agent_id"
    t.integer  "status_option_id"
    t.integer  "project_type_option_id"
    t.integer  "loan_type_option_id"
    t.integer  "public_level_option_id"
    t.decimal  "amount",                      precision: 12, scale: 2
    t.integer  "currency_id"
    t.decimal  "rate",                        precision: 8,  scale: 4
    t.integer  "length_months"
    t.integer  "representative_id"
    t.date     "signing_date"
    t.date     "first_payment_date"
    t.date     "first_interest_payment_date"
    t.date     "target_end_date"
    t.decimal  "projected_return",            precision: 12, scale: 2
    t.integer  "organization_size"
    t.integer  "woman_ownership_percent"
    t.integer  "poc_ownership_percent"
    t.integer  "environmental_impact_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loans", ["division_id"], name: "index_loans_on_division_id", using: :btree
  add_index "loans", ["organization_id"], name: "index_loans_on_organization_id", using: :btree

  create_table "organizations", force: true do |t|
    t.integer  "division_id"
    t.string   "display_name"
    t.string   "legal_name"
    t.string   "primary_phone"
    t.string   "secondary_phone"
    t.string   "fax"
    t.string   "email"
    t.string   "street_address"
    t.string   "city"
    t.string   "neighborhood"
    t.string   "state"
    t.integer  "country_id"
    t.string   "tax_no"
    t.string   "website"
    t.text     "notes"
    t.string   "alias"
    t.integer  "primary_contact_id"
    t.string   "sector"
    t.string   "industry"
    t.string   "referral_source"
    t.integer  "organization_size"
    t.integer  "woman_ownership_percent"
    t.integer  "poc_ownership_percent"
    t.integer  "environmental_impact_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations", ["division_id"], name: "index_organizations_on_division_id", using: :btree

  create_table "people", force: true do |t|
    t.integer  "division_id"
    t.string   "display_name"
    t.string   "legal_name"
    t.string   "primary_phone"
    t.string   "secondary_phone"
    t.string   "fax"
    t.string   "email"
    t.string   "street_address"
    t.string   "city"
    t.string   "neighborhood"
    t.string   "state"
    t.integer  "country_id"
    t.string   "tax_no"
    t.string   "website"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "primary_organization_id"
  end

  add_index "people", ["division_id"], name: "index_people_on_division_id", using: :btree
  add_index "people", ["primary_organization_id"], name: "index_people_on_primary_organization_id", using: :btree

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
