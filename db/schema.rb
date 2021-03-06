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

ActiveRecord::Schema.define(version: 20140909062745) do

  create_table "documents", force: true do |t|
    t.integer  "user_id",                    null: false
    t.string   "title",                      null: false
    t.text     "content"
    t.integer  "words",      default: 0,     null: false
    t.integer  "goal",                       null: false
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "shared",     default: false
  end

  add_index "documents", ["user_id", "year", "month", "day"], name: "index_documents_on_user_id_and_year_and_month_and_day"

  create_table "users", force: true do |t|
    t.string   "username",        limit: 24,                                         null: false
    t.string   "password_digest",                                                    null: false
    t.string   "email",           limit: 128,                                        null: false
    t.integer  "ip",              limit: 8
    t.integer  "goal",                        default: 500,                          null: false
    t.string   "time_zone",                   default: "Pacific Time (US & Canada)", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
