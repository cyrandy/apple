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

ActiveRecord::Schema.define(version: 20131103014338) do

  create_table "auctions", force: true do |t|
    t.string   "title"
    t.string   "link"
    t.string   "guid"
    t.string   "img"
    t.string   "price"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_post"
    t.text     "description"
  end

  add_index "auctions", ["guid"], name: "index_auctions_on_guid"

  create_table "records", force: true do |t|
    t.string   "link"
    t.string   "guid"
    t.string   "auction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "fb_id"
    t.string   "fb_name"
    t.text     "fb_access_token"
    t.string   "y_auction_id"
    t.string   "y_oauth_token"
    t.string   "y_oauth_verifier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "fb_page_access_token"
    t.string   "fb_picture"
    t.text     "page_description"
    t.string   "fb_fan_page"
  end

end
