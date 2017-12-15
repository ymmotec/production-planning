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

ActiveRecord::Schema.define(version: 20171207091341) do

  create_table "Products", force: :cascade do |t|
    t.string "name"
    t.integer "customer_id_number"
    t.string "internal_id_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.integer "quantity_on_palet"
    t.integer "product_family_id"
    t.integer "min_production"
    t.integer "max_production"
    t.integer "min_stock"
    t.integer "max_stock"
    t.integer "lack_group"
    t.string "size"
    t.decimal "palet_size"
    t.string "status"
    t.integer "max_orders_per_week"
    t.integer "lead_time"
    t.integer "average_spi"
    t.integer "average_sale"
    t.integer "average_order_qty"
  end

  create_table "com40_files", force: :cascade do |t|
    t.string "file"
    t.date "stock_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "com40s", force: :cascade do |t|
    t.integer "product_id"
    t.integer "quantity_in_stock"
    t.integer "com40_file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "elements", force: :cascade do |t|
    t.string "name"
    t.string "internal_id_number"
    t.integer "quantity_per_set"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "machines", force: :cascade do |t|
    t.string "name"
    t.string "factory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "OEE"
  end

  create_table "open_order_details", force: :cascade do |t|
    t.integer "product_id"
    t.integer "open_order_id"
    t.string "rcv"
    t.string "cty"
    t.integer "orig_qty"
    t.integer "bal_qty"
    t.date "orig_date"
    t.string "sl"
    t.integer "orig_week"
    t.string "mtype"
    t.integer "bkd_qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_order_files", force: :cascade do |t|
    t.string "file"
    t.date "open_orders_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_orders", force: :cascade do |t|
    t.string "order"
    t.integer "open_order_file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "element_id"
    t.integer "machine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "efficiency_per_shift"
    t.decimal "cycle_time"
    t.index ["element_id"], name: "index_operations_on_element_id"
    t.index ["machine_id"], name: "index_operations_on_machine_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
    t.string "rcv"
    t.string "cty"
    t.integer "orig_qty"
    t.date "orig_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "orig_week"
  end

  create_table "order_files", force: :cascade do |t|
    t.string "file"
    t.date "order_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "order"
    t.integer "order_file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.datetime "final_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_families", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "production_orders", force: :cascade do |t|
    t.integer "product_id"
    t.integer "plan_id"
    t.integer "ordered_qty"
    t.string "status"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_production_orders_on_plan_id"
    t.index ["product_id"], name: "index_production_orders_on_product_id"
  end

  create_table "spi_files", force: :cascade do |t|
    t.string "file"
    t.date "spi_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "spi_infos", force: :cascade do |t|
    t.integer "spi_file_id"
    t.integer "product_id"
    t.string "art_status"
    t.integer "store_assets"
    t.integer "dc_stock"
    t.integer "safety_stock"
    t.integer "in_transit"
    t.integer "open_orders"
    t.integer "sales_forecast"
    t.integer "supply_plan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spis", force: :cascade do |t|
    t.string "week"
    t.integer "qty"
    t.integer "product_id"
    t.integer "spi_file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_files", force: :cascade do |t|
    t.string "file"
    t.date "stock_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "product_id"
    t.integer "quantity_in_stock"
    t.integer "stock_file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
