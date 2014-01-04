# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140104190101) do

  create_table "causes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donations", force: true do |t|
    t.integer  "npo_id"
    t.integer  "user_id"
    t.float    "amount_donated"
    t.integer  "calories_donated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.integer  "cause_id"
    t.text     "description"
    t.float    "fund"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "npos", force: true do |t|
    t.string   "name"
    t.float    "rate"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats", force: true do |t|
    t.integer  "today_active_calories"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "step_count_walking"
    t.integer  "step_count_running"
    t.integer  "seconds_walking"
    t.integer  "seconds_running"
    t.float    "kilometers_walking"
    t.float    "kilometers_running"
    t.integer  "calories_burned_walking"
    t.integer  "calories_burned_running"
    t.string   "data_source"
  end

#  create_table "user_stats", force: true do |t|
#    t.integer  "calory_in"
#    t.integer  "calory_out"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "height"
    t.integer  "weight"
    t.string   "user_type"
    t.string   "name"
    t.string   "gender"
    t.date     "dob"
    t.integer  "company_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.integer  "user_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
