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

ActiveRecord::Schema.define(version: 20170209195328) do

  create_table "mybookings_bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
    t.integer  "resource_type_id"
    t.string   "booking_type"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "until_date"
    t.integer  "recurrent_type",   default: 0
    t.boolean  "prepared",         default: false
  end

  add_index "mybookings_bookings", ["resource_type_id"], name: "index_mybookings_bookings_on_resource_type_id"
  add_index "mybookings_bookings", ["user_id"], name: "index_mybookings_bookings_on_user_id_and_resource_id"

  create_table "mybookings_events", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "status",      default: 0, null: false
    t.text     "feedback"
    t.integer  "booking_id"
    t.integer  "resource_id"
    t.string   "event_type"
  end

  add_index "mybookings_events", ["booking_id"], name: "index_mybookings_events_on_booking_id"
  add_index "mybookings_events", ["resource_id"], name: "index_mybookings_events_on_resource_id"

  create_table "mybookings_resource_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "extension",  default: "DefaultExtension"
    t.integer  "roles_mask"
  end

  create_table "mybookings_resources", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "disabled",         default: false
    t.integer  "resource_type_id"
  end

  add_index "mybookings_resources", ["name"], name: "index_mybookings_resources_on_name"

  create_table "mybookings_user_managed_resource_types", force: :cascade do |t|
    t.integer "user_id"
    t.integer "resource_type_id"
  end

  create_table "mybookings_users", force: :cascade do |t|
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
    t.string   "provider"
    t.string   "uid"
    t.integer  "roles_mask"
  end

  add_index "mybookings_users", ["email"], name: "index_mybookings_users_on_email", unique: true
  add_index "mybookings_users", ["reset_password_token"], name: "index_mybookings_users_on_reset_password_token", unique: true

end
