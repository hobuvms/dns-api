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

ActiveRecord::Schema.define(version: 20190222171415) do

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "vendor_id"
    t.bigint "user_id"
    t.integer "product_id"
    t.string "account_number"
    t.string "working_order"
    t.string "company_name"
    t.float "price", limit: 24
    t.datetime "installation"
    t.datetime "expiry_date"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
    t.index ["vendor_id"], name: "index_orders_on_vendor_id"
  end

  create_table "user_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "formatted_address"
    t.string "postal_code"
    t.float "latitude", limit: 24
    t.float "longitude", limit: 24
    t.string "city"
    t.string "country_name"
    t.string "region_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_addresses_on_user_id"
  end

  create_table "user_leads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "vendor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "medium"
    t.string "phone"
    t.index ["user_id"], name: "index_user_leads_on_user_id"
    t.index ["vendor_id"], name: "index_user_leads_on_vendor_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "role"
    t.integer "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "referral_code"
    t.string "company_name"
    t.string "notes"
    t.string "medium"
    t.index ["email"], name: "index_users_on_email"
    t.index ["referral_code"], name: "index_users_on_referral_code"
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "item_type", limit: 191, null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 4294967295
    t.datetime "created_at"
    t.text "object_changes", limit: 4294967295
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "orders", "users"
  add_foreign_key "orders", "users", column: "vendor_id"
  add_foreign_key "user_addresses", "users"
  add_foreign_key "user_leads", "users"
  add_foreign_key "user_leads", "users", column: "vendor_id"
end
