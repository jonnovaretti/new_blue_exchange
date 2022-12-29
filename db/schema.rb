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

ActiveRecord::Schema[7.0].define(version: 2022_12_28_234151) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "symbol"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", force: :cascade do |t|
    t.decimal "amount", null: false
    t.decimal "unit_price", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state", default: "created", null: false
    t.bigint "currency_amount_id", null: false
    t.bigint "currency_unit_price_id", null: false
    t.index ["id", "currency_amount_id", "currency_unit_price_id"], name: "index_id_and_currency_amount_and_unit_price_id", unique: true
    t.index ["id", "currency_amount_id"], name: "index_offers_on_id_and_currency_amount_id"
    t.index ["id", "currency_unit_price_id"], name: "index_offers_on_id_and_currency_unit_price_id"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.decimal "available_amount", precision: 14, scale: 4, default: "0.0", null: false
    t.decimal "hold_amount", precision: 14, scale: 4, default: "0.0", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "currency_id", null: false
    t.index ["id", "currency_id"], name: "index_wallets_on_id_and_currency_id", unique: true
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "offers", "currencies", column: "currency_amount_id"
  add_foreign_key "offers", "currencies", column: "currency_unit_price_id"
  add_foreign_key "offers", "users"
  add_foreign_key "wallets", "currencies"
  add_foreign_key "wallets", "users"
end
