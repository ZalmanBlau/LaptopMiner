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

ActiveRecord::Schema.define(version: 20151208185059) do

  create_table "laptops", force: :cascade do |t|
    t.string  "name"
    t.string  "brand"
    t.string  "color"
    t.string  "url"
    t.string  "image_url"
    t.text    "description"
    t.float   "price"
    t.integer "ram"
    t.integer "hard_drive_gb"
    t.string  "proccessor"
    t.float   "weight"
    t.integer "battery_life"
    t.float   "screen_size"
    t.string  "model_number"
    t.string  "upc"
  end

end
