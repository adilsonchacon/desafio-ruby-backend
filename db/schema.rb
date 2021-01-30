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

ActiveRecord::Schema.define(version: 2021_01_29_223045) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "credit_cards", force: :cascade do |t|
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "transaction_type_id", null: false
    t.bigint "store_owner_id", null: false
    t.bigint "recipient_credit_card_id", null: false
    t.date "occurrence_date"
    t.time "occurrence_time"
    t.float "occurrence_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipient_credit_card_id"], name: "index_orders_on_recipient_credit_card_id"
    t.index ["store_owner_id"], name: "index_orders_on_store_owner_id"
    t.index ["transaction_type_id"], name: "index_orders_on_transaction_type_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "recipient_credit_cards", force: :cascade do |t|
    t.bigint "recipient_id", null: false
    t.bigint "credit_card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["credit_card_id"], name: "index_recipient_credit_cards_on_credit_card_id"
    t.index ["recipient_id"], name: "index_recipient_credit_cards_on_recipient_id"
  end

  create_table "recipients", force: :cascade do |t|
    t.string "cpf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "store_owners", force: :cascade do |t|
    t.bigint "store_id", null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_store_owners_on_owner_id"
    t.index ["store_id"], name: "index_store_owners_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transaction_types", force: :cascade do |t|
    t.integer "type_id"
    t.string "description"
    t.string "nature"
    t.string "signal"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "orders", "recipient_credit_cards"
  add_foreign_key "orders", "store_owners"
  add_foreign_key "orders", "transaction_types"
  add_foreign_key "recipient_credit_cards", "credit_cards"
  add_foreign_key "recipient_credit_cards", "recipients"
  add_foreign_key "store_owners", "owners"
  add_foreign_key "store_owners", "stores"
end
