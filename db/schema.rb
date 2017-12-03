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

ActiveRecord::Schema.define(version: 20171203124318) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "loans", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repayments", force: :cascade do |t|
    t.bigint "tranche_id"
    t.integer "month_number"
    t.decimal "amount"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tranche_id"], name: "index_repayments_on_tranche_id"
  end

  create_table "tranches", force: :cascade do |t|
    t.bigint "loan_id"
    t.decimal "amount"
    t.integer "term"
    t.decimal "base_rate"
    t.decimal "overdue_rate"
    t.decimal "monthly_main_debt_payment"
    t.decimal "monthly_percent_payment"
    t.decimal "monthly_total_payment"
    t.decimal "total_to_pay"
    t.decimal "percent_repaid"
    t.decimal "main_debt_repaid"
    t.decimal "real_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_tranches_on_loan_id"
  end

  add_foreign_key "repayments", "tranches", column: "tranche_id"
  add_foreign_key "tranches", "loans"
end
