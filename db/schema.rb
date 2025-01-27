# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_01_26_225443) do
  create_table "cart_items", force: :cascade do |t|
    t.integer "cart_id", null: false
    t.string "purchasable_type", null: false
    t.integer "purchasable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["purchasable_type", "purchasable_id"], name: "index_cart_items_on_purchasable"
  end

  create_table "carts", force: :cascade do |t|
    t.decimal "total_price", precision: 17, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customization_items", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 17, scale: 2, null: false
    t.boolean "in_stock", default: true
    t.integer "customization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customization_id"], name: "index_customization_items_on_customization_id"
  end

  create_table "customizations", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_customizations_on_category_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "in_stock", default: true
    t.decimal "price", precision: 17, scale: 2, null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "prohibited_combinations", force: :cascade do |t|
    t.integer "customization_item_id", null: false
    t.integer "prohibited_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customization_item_id", "prohibited_item_id"], name: "index_prohibited_combinations_uniqueness", unique: true
    t.index ["customization_item_id"], name: "index_prohibited_combinations_on_customization_item_id"
    t.index ["prohibited_item_id"], name: "index_prohibited_combinations_on_prohibited_item_id"
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "customization_items", "customizations"
  add_foreign_key "customizations", "categories"
  add_foreign_key "products", "categories"
  add_foreign_key "prohibited_combinations", "customization_items"
  add_foreign_key "prohibited_combinations", "customization_items", column: "prohibited_item_id"
end
