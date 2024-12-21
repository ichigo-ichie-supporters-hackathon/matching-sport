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

ActiveRecord::Schema[7.0].define(version: 2024_12_20_134138) do
  create_table "events", force: :cascade do |t|
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "comment"
    t.integer "people_count"
    t.string "position"
    t.integer "subgenre_id", null: false
    t.integer "user_id", null: false
    t.integer "unmetched_gender"
    t.integer "unmatched_age_min"
    t.integer "unmatched_age_max"
    t.boolean "is_accepted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "matched_id"
    t.index ["matched_id"], name: "index_events_on_matched_id"
    t.index ["subgenre_id"], name: "index_events_on_subgenre_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matching_event_groups", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_matching_event_groups_on_event_id"
    t.index ["user_id"], name: "index_matching_event_groups_on_user_id"
  end

  create_table "subgenres", force: :cascade do |t|
    t.string "name"
    t.integer "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_subgenres_on_genre_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.integer "age", null: false
    t.integer "gender", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "events", column: "matched_id"
  add_foreign_key "events", "subgenres"
  add_foreign_key "events", "users"
  add_foreign_key "matching_event_groups", "events"
  add_foreign_key "matching_event_groups", "users"
  add_foreign_key "subgenres", "genres"
end
