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

ActiveRecord::Schema.define(version: 20150630104616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bulk_imports", force: true do |t|
    t.boolean  "status"
    t.date     "collection_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bulk_imports", ["user_id"], name: "index_bulk_imports_on_user_id", using: :btree

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "mobile_number"
    t.string   "phone_number"
    t.string   "email_id"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customers", ["location"], name: "index_customers_on_location", using: :btree
  add_index "customers", ["mobile_number"], name: "index_customers_on_mobile_number", using: :btree
  add_index "customers", ["name"], name: "index_customers_on_name", using: :btree

  create_table "daily_collections", force: true do |t|
    t.integer  "loan_id"
    t.float    "amount"
    t.date     "collection_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "daily_collections", ["loan_id"], name: "index_daily_collections_on_loan_id", using: :btree
  add_index "daily_collections", ["user_id"], name: "index_daily_collections_on_user_id", using: :btree

  create_table "entries", force: true do |t|
    t.integer  "entry_type_id"
    t.integer  "user_id"
    t.float    "amount"
    t.date     "entry_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["entry_type_id"], name: "index_entries_on_entry_type_id", using: :btree
  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "entry_types", force: true do |t|
    t.string   "name"
    t.boolean  "income"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loans", force: true do |t|
    t.integer  "customer_id"
    t.integer  "order_no"
    t.integer  "loan_type"
    t.integer  "vasool_day"
    t.date     "given_date"
    t.float    "loan_amount"
    t.float    "given_amount"
    t.float    "installment_amount"
    t.integer  "installments"
    t.float    "paid_amount"
    t.float    "balance_amount"
    t.boolean  "active_status",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loans", ["active_status"], name: "index_loans_on_active_status", using: :btree
  add_index "loans", ["customer_id"], name: "index_loans_on_customer_id", using: :btree
  add_index "loans", ["loan_type"], name: "index_loans_on_loan_type", using: :btree
  add_index "loans", ["order_no"], name: "index_loans_on_order_no", unique: true, using: :btree
  add_index "loans", ["vasool_day"], name: "index_loans_on_vasool_day", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: ""
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
