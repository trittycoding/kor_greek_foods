# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_09_234158) do

  create_table "bees", force: :cascade do |t|
    t.string "uses"
    t.string "source"
    t.integer "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_bees_on_product_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "herbs", force: :cascade do |t|
    t.string "description"
    t.string "benefits"
    t.string "instructions"
    t.integer "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_herbs_on_product_id"
  end

  create_table "honeys", force: :cascade do |t|
    t.string "type"
    t.string "source"
    t.string "harvest"
    t.string "benefits"
    t.string "crystallization"
    t.integer "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_honeys_on_product_id"
  end

  create_table "oliveoils", force: :cascade do |t|
    t.string "variety"
    t.decimal "acidity"
    t.string "appearance"
    t.string "aroma"
    t.string "taste"
    t.string "uses"
    t.string "size"
    t.integer "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_oliveoils_on_product_id"
  end

  create_table "olives", force: :cascade do |t|
    t.string "benefits"
    t.string "size"
    t.string "storage"
    t.integer "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_olives_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "total"
    t.integer "purchasedby"
    t.decimal "unitcost"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "productorders", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_productorders_on_order_id"
    t.index ["product_id"], name: "index_productorders_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "sku"
    t.decimal "price"
    t.integer "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "distributor"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "bees", "products"
  add_foreign_key "herbs", "products"
  add_foreign_key "honeys", "products"
  add_foreign_key "oliveoils", "products"
  add_foreign_key "olives", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "productorders", "orders"
  add_foreign_key "productorders", "products"
  add_foreign_key "products", "categories"
end
