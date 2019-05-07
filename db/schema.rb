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

ActiveRecord::Schema.define(version: 2019_05_07_172138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "clubs", force: :cascade do |t|
    t.string "number", default: ""
    t.date "date_of_issue"
    t.date "valid_to"
    t.string "call_sign", default: ""
    t.string "category", default: ""
    t.integer "transmitter_power"
    t.string "enduser_name", default: ""
    t.string "enduser_city", default: ""
    t.string "enduser_street", default: ""
    t.string "enduser_house", default: ""
    t.string "enduser_number", default: ""
    t.string "applicant_name", default: ""
    t.string "applicant_city", default: ""
    t.string "applicant_street", default: ""
    t.string "applicant_house", default: ""
    t.string "applicant_number", default: ""
    t.string "station_city", default: ""
    t.string "station_street", default: ""
    t.string "station_house", default: ""
    t.string "station_number", default: ""
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_city"], name: "index_clubs_on_applicant_city"
    t.index ["applicant_house"], name: "index_clubs_on_applicant_house"
    t.index ["applicant_name"], name: "index_clubs_on_applicant_name"
    t.index ["applicant_number"], name: "index_clubs_on_applicant_number"
    t.index ["applicant_street"], name: "index_clubs_on_applicant_street"
    t.index ["call_sign"], name: "index_clubs_on_call_sign"
    t.index ["category"], name: "index_clubs_on_category"
    t.index ["date_of_issue"], name: "index_clubs_on_date_of_issue"
    t.index ["enduser_city"], name: "index_clubs_on_enduser_city"
    t.index ["enduser_house"], name: "index_clubs_on_enduser_house"
    t.index ["enduser_name"], name: "index_clubs_on_enduser_name"
    t.index ["enduser_number"], name: "index_clubs_on_enduser_number"
    t.index ["enduser_street"], name: "index_clubs_on_enduser_street"
    t.index ["lat"], name: "index_clubs_on_lat"
    t.index ["lng"], name: "index_clubs_on_lng"
    t.index ["number"], name: "index_clubs_on_number"
    t.index ["station_city"], name: "index_clubs_on_station_city"
    t.index ["station_house"], name: "index_clubs_on_station_house"
    t.index ["station_number"], name: "index_clubs_on_station_number"
    t.index ["station_street"], name: "index_clubs_on_station_street"
    t.index ["transmitter_power"], name: "index_clubs_on_transmitter_power"
    t.index ["valid_to"], name: "index_clubs_on_valid_to"
  end

  create_table "departments", force: :cascade do |t|
    t.string "short", limit: 15, default: "", null: false
    t.string "name", limit: 100, default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_departments_on_name", unique: true
    t.index ["short"], name: "index_departments_on_short", unique: true
  end

  create_table "individuals", force: :cascade do |t|
    t.string "number", default: ""
    t.date "date_of_issue"
    t.date "valid_to"
    t.string "call_sign", default: ""
    t.string "category", default: ""
    t.integer "transmitter_power"
    t.string "station_location", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["call_sign"], name: "index_individuals_on_call_sign"
    t.index ["category"], name: "index_individuals_on_category"
    t.index ["date_of_issue"], name: "index_individuals_on_date_of_issue"
    t.index ["number"], name: "index_individuals_on_number"
    t.index ["station_location"], name: "index_individuals_on_station_location"
    t.index ["transmitter_power"], name: "index_individuals_on_transmitter_power"
    t.index ["valid_to"], name: "index_individuals_on_valid_to"
  end

  create_table "old_passwords", force: :cascade do |t|
    t.string "encrypted_password", null: false
    t.string "password_salt"
    t.string "password_archivable_type", null: false
    t.integer "password_archivable_id", null: false
    t.datetime "created_at"
    t.index ["password_archivable_type", "password_archivable_id"], name: "index_password_archivable"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "activities", default: [], array: true
    t.text "note", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id", unique: true
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id", unique: true
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.text "position", default: ""
    t.bigint "department_id"
    t.text "note", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.datetime "last_activity_at"
    t.datetime "expired_at"
    t.datetime "password_changed_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "works", force: :cascade do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "trackable_url"
    t.bigint "user_id"
    t.string "action"
    t.text "parameters"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trackable_type", "trackable_id"], name: "index_works_on_trackable_type_and_trackable_id"
    t.index ["user_id"], name: "index_works_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "roles_users", "roles"
  add_foreign_key "roles_users", "users"
  add_foreign_key "users", "departments"
end
