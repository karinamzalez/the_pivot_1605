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

ActiveRecord::Schema.define(version: 20160817165023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_items", force: :cascade do |t|
    t.integer "business_id"
    t.integer "item_id"
    t.index ["business_id"], name: "index_business_items_on_business_id", using: :btree
    t.index ["item_id"], name: "index_business_items_on_item_id", using: :btree
  end

  create_table "businesses", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "slug"
    t.index ["user_id"], name: "index_businesses_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string  "name"
    t.decimal "price"
    t.text    "description"
    t.integer "category_id"
    t.string  "image_url"
    t.boolean "status",      default: false
    t.index ["category_id"], name: "index_items_on_category_id", using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "quantity"
    t.decimal "subtotal"
    t.integer "item_id"
    t.index ["item_id"], name: "index_order_items_on_item_id", using: :btree
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "total_price"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",      default: 0
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0
    t.string   "email"
  end

  add_foreign_key "business_items", "businesses"
  add_foreign_key "business_items", "items"
  add_foreign_key "businesses", "users"
  add_foreign_key "items", "categories"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
end
