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

ActiveRecord::Schema.define(version: 20190813165736) do

  create_table "area_of_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "country"
    t.string "region"
  end

  create_table "area_of_services_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id",            null: false
    t.integer "area_of_service_id", null: false
    t.index ["area_of_service_id", "user_id"], name: "index_area_of_services_users_on_area_of_service_id_and_user_id", using: :btree
    t.index ["user_id", "area_of_service_id"], name: "index_area_of_services_users_on_user_id_and_area_of_service_id", using: :btree
  end

  create_table "calendar_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "time_schema_id"
    t.integer  "event_type"
    t.integer  "listing_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["listing_id"], name: "index_calendar_events_on_listing_id", using: :btree
    t.index ["time_schema_id"], name: "index_calendar_events_on_time_schema_id", using: :btree
    t.index ["user_id"], name: "index_calendar_events_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "parent_id"
    t.string   "url"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_categories_on_parent_id", using: :btree
  end

  create_table "customer_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.float    "latitude",     limit: 24
    t.float    "longitude",    limit: 24
    t.string   "full_address"
    t.integer  "phone"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["order_id"], name: "index_customer_addresses_on_order_id", using: :btree
    t.index ["user_id"], name: "index_customer_addresses_on_user_id", using: :btree
  end

  create_table "dns_point_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dns_point_logs_on_user_id", using: :btree
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "bytes"
    t.string   "url"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree
  end

  create_table "invitations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "friend_email"
    t.string   "code"
    t.boolean  "valid"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["code"], name: "index_invitations_on_code", using: :btree
    t.index ["user_id"], name: "index_invitations_on_user_id", using: :btree
  end

  create_table "listing_attributes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "listing_id"
    t.string  "attribute_name"
  end

  create_table "listings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "views"
    t.string   "description"
    t.integer  "category_id"
    t.boolean  "disabled"
    t.float    "price_per_hour",    limit: 24
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "user_id"
    t.integer  "offer_price"
    t.string   "offer_description"
    t.integer  "listing_level",                default: 1
    t.index ["listing_level"], name: "index_listings_on_listing_level", using: :btree
  end

  create_table "order_adjustments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "order_uuid"
    t.decimal  "price",           precision: 10
    t.string   "notes"
    t.integer  "adjustment_type"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["order_uuid"], name: "index_order_adjustments_on_order_uuid", using: :btree
  end

  create_table "order_attributes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "order_id"
    t.integer "listing_attribute_id"
    t.string  "value"
    t.index ["order_id"], name: "index_order_attributes_on_order_id", using: :btree
  end

  create_table "order_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "order_uuid"
    t.decimal  "per_hour_cost",            precision: 10
    t.float    "duration",      limit: 24
    t.string   "ip"
    t.integer  "device"
    t.string   "notes"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "approx_tax"
    t.string   "source"
    t.index ["order_uuid"], name: "index_order_details_on_order_uuid", using: :btree
  end

  create_table "order_tracking_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "order_uuid"
    t.string   "state"
    t.string   "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_uuid"], name: "index_order_tracking_details_on_order_uuid", using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "uuid"
    t.string   "vendor_uuid"
    t.decimal  "total",        precision: 10
    t.string   "state"
    t.integer  "listing_id"
    t.string   "slot"
    t.datetime "scheduled_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "user_uuid"
    t.index ["user_uuid"], name: "index_orders_on_user_uuid", using: :btree
    t.index ["uuid"], name: "index_orders_on_uuid", using: :btree
    t.index ["vendor_uuid"], name: "index_orders_on_vendor_uuid", using: :btree
  end

  create_table "time_schemas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "time_value"
    t.string  "day_name"
    t.string  "time_name"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "role",                             default: 100
    t.string   "password_digest"
    t.integer  "dns_points"
    t.datetime "dob"
    t.integer  "gender"
    t.string   "phone"
    t.boolean  "is_verified"
    t.string   "verification_token"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.text     "bio",                limit: 65535
    t.string   "uuid"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["password_digest"], name: "index_users_on_password_digest", using: :btree
    t.index ["role"], name: "index_users_on_role", using: :btree
    t.index ["username"], name: "index_users_on_username", using: :btree
    t.index ["uuid"], name: "index_users_on_uuid", unique: true, using: :btree
  end

  create_table "vendor_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "unit"
    t.string   "area"
    t.string   "city"
    t.string   "province"
    t.string   "postal_code"
    t.integer  "experience_level"
    t.string   "pitch"
    t.integer  "image1_id"
    t.integer  "image2_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "latitude"
    t.string   "longitude"
    t.string   "address_text"
  end

  add_foreign_key "calendar_events", "time_schemas"
  add_foreign_key "calendar_events", "users"
  add_foreign_key "customer_addresses", "orders"
  add_foreign_key "customer_addresses", "users"
  add_foreign_key "dns_point_logs", "users"
  add_foreign_key "invitations", "users"
  add_foreign_key "order_adjustments", "orders", column: "order_uuid", primary_key: "uuid"
  add_foreign_key "order_attributes", "orders"
  add_foreign_key "order_details", "orders", column: "order_uuid", primary_key: "uuid"
  add_foreign_key "order_tracking_details", "orders", column: "order_uuid", primary_key: "uuid"
  add_foreign_key "orders", "users", column: "user_uuid", primary_key: "uuid"
  add_foreign_key "orders", "users", column: "vendor_uuid", primary_key: "uuid"
end
