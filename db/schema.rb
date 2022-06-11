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

ActiveRecord::Schema.define(version: 2022_06_11_083340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tender_id", null: false
    t.bigint "user_id", null: false
    t.float "quote"
    t.boolean "approved"
    t.index ["tender_id"], name: "index_bids_on_tender_id"
    t.index ["user_id"], name: "index_bids_on_user_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "bid_id", null: false
    t.boolean "has_client_signed"
    t.boolean "has_builder_signed"
    t.boolean "completed"
    t.integer "duration"
    t.index ["bid_id"], name: "index_contracts_on_bid_id"
  end

  create_table "tenders", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "estimated_budget"
    t.text "description"
    t.string "nature_of_works"
    t.string "location"
    t.text "specifications"
    t.date "estimated_start_date"
    t.date "estimated_end_date"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_tenders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "grade_of_contractor"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.boolean "is_builder"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bids", "tenders"
  add_foreign_key "bids", "users"
  add_foreign_key "contracts", "bids"
  add_foreign_key "tenders", "users"
end
