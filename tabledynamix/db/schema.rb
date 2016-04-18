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

ActiveRecord::Schema.define(version: 20160418174559) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_restaurants", id: false, force: :cascade do |t|
    t.integer "category_id",   null: false
    t.integer "restaurant_id", null: false
  end

  add_index "categories_restaurants", ["category_id", "restaurant_id"], name: "index_categories_restaurants_on_category_id_and_restaurant_id"
  add_index "categories_restaurants", ["restaurant_id", "category_id"], name: "index_categories_restaurants_on_restaurant_id_and_category_id"

  create_table "customers", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.date     "date"
    t.time     "time"
    t.integer  "customer_id"
    t.integer  "restaurant_id"
    t.integer  "party_size"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.integer  "capacity"
    t.integer  "owner_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.string   "phone"
    t.time     "open_time"
    t.time     "close_time"
    t.integer  "price"
    t.text     "menu"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "picture"
  end

end
