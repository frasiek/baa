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

ActiveRecord::Schema.define(version: 20150103154648) do

  create_table "bank_accounts", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "user_id", limit: 4, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bank_accounts", ["user_id"], name: "fk_bank_accounts_users1", using: :btree

  create_table "operation_types", force: :cascade do |t|
    t.string "type", limit: 45
  end

  create_table "operations", force: :cascade do |t|
    t.integer "users_user_id", limit: 4, null: false
    t.integer "bank_accounts_id", limit: 4, null: false
    t.integer "type_id", limit: 4, null: false
    t.date "accounting_date"
    t.date "currency_date"
    t.string "details_recipient", limit: 500
    t.string "account_recipient", limit: 45
    t.string "title", limit: 250
    t.decimal "value", precision: 20, scale: 2
    t.string "currency", limit: 5
    t.string "ref_no", limit: 45
  end

  add_index "operations", ["bank_accounts_id"], name: "fk_operations_bank_accounts1", using: :btree
  add_index "operations", ["type_id"], name: "fk_operations_operation_types1", using: :btree
  add_index "operations", ["users_user_id"], name: "fk_operations_users1", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.text "file", limit: 65535, null: false
    t.integer "bank_account_id", limit: 4, null: false
    t.integer "user_id", limit: 4, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transactions", ["bank_account_id"], name: "fk_transactions_2", using: :btree
  add_index "transactions", ["user_id"], name: "fk_transactions_1", using: :btree

  create_table "user_login_history", primary_key: "user_login_history_id", force: :cascade do |t|
    t.integer "user_id", limit: 4, null: false
    t.datetime "login_at", null: false
    t.boolean "success", limit: 1, null: false
    t.string "ip_address", limit: 15, null: false
  end

  add_index "user_login_history", ["user_id"], name: "fk_baa_user_login_history_baa_user", using: :btree

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string "email", limit: 250, null: false
    t.string "password_hash", limit: 250, null: false
    t.boolean "active", limit: 1, default: false, null: false
    t.datetime "create_at", null: false
  end

  add_index "users", ["email"], name: "email_UNIQUE", unique: true, using: :btree

  add_foreign_key "bank_accounts", "users", primary_key: "user_id", name: "fk_bank_accounts_users1"
  add_foreign_key "operations", "bank_accounts", column: "bank_accounts_id", name: "fk_operations_bank_accounts1"
  add_foreign_key "operations", "operation_types", column: "type_id", name: "fk_operations_operation_types1"
  add_foreign_key "operations", "users", column: "users_user_id", primary_key: "user_id", name: "fk_operations_users1"
  add_foreign_key "transactions", "bank_accounts", name: "fk_transactions_2"
  add_foreign_key "transactions", "users", primary_key: "user_id", name: "fk_transactions_1"
  add_foreign_key "user_login_history", "users", primary_key: "user_id", name: "fk_baa_user_login_history_baa_user"
end
