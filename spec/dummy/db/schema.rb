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

ActiveRecord::Schema.define(version: 20180315163832) do

  create_table "mybookings_bookings", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "comment"
    t.integer "resource_type_id"
    t.string "booking_type"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "until_date"
    t.integer "recurrent_type", default: 0
    t.boolean "prepared", default: false
    t.datetime "deleted_at"
    t.integer "proposed_resource_id"
    t.index ["deleted_at"], name: "index_mybookings_bookings_on_deleted_at"
    t.index ["proposed_resource_id"], name: "index_mybookings_bookings_on_proposed_resource_id"
    t.index ["resource_type_id"], name: "index_mybookings_bookings_on_resource_type_id"
    t.index ["user_id"], name: "index_mybookings_bookings_on_user_id_and_resource_id"
  end

  create_table "mybookings_events", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "status", default: 0, null: false
    t.text "feedback"
    t.integer "booking_id"
    t.integer "resource_id"
    t.string "event_type"
    t.datetime "deleted_at"
    t.datetime "start_date_advanced"
    t.datetime "end_date_delayed"
    t.index ["booking_id"], name: "index_mybookings_events_on_booking_id"
    t.index ["deleted_at"], name: "index_mybookings_events_on_deleted_at"
    t.index ["resource_id"], name: "index_mybookings_events_on_resource_id"
  end

  create_table "mybookings_resource_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "extension", default: "DefaultExtension"
    t.integer "roles_mask"
    t.datetime "deleted_at"
    t.string "notifications_email_from"
    t.text "notifications_emails"
    t.integer "minutes_in_advance", default: 1
    t.integer "minutes_of_grace", default: 1
    t.integer "limit_hours_duration", default: 24
    t.integer "limit_days_for_recurring_events", default: 365
    t.integer "limit_days_for_feedback", default: 7
    t.boolean "hide_comment_field", default: false
    t.index ["deleted_at"], name: "index_mybookings_resource_types_on_deleted_at"
  end

  create_table "mybookings_resources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "disabled", default: false
    t.integer "resource_type_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_mybookings_resources_on_deleted_at"
    t.index ["name"], name: "index_mybookings_resources_on_name"
  end

  create_table "mybookings_user_managed_resource_types", force: :cascade do |t|
    t.integer "user_id"
    t.integer "resource_type_id"
  end

  create_table "mybookings_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "provider"
    t.string "uid"
    t.integer "roles_mask"
    t.datetime "deleted_at"
    t.string "first_name"
    t.string "last_name"
    t.index ["deleted_at"], name: "index_mybookings_users_on_deleted_at"
    t.index ["email"], name: "index_mybookings_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_mybookings_users_on_reset_password_token", unique: true
  end

end
