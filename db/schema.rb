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

ActiveRecord::Schema[7.1].define(version: 2025_02_28_131149) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendships", force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_friendships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_friendships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_friendships_on_follower_id"
  end

  create_table "sleep_trackings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "clock_in", null: false
    t.datetime "clock_out"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "clock_in"], name: "index_tracking_logs_on_user_id_and_clock_in"
    t.index ["user_id"], name: "index_sleep_trackings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "api_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_token"], name: "index_api_token"
  end

  add_foreign_key "friendships", "users", column: "followed_id"
  add_foreign_key "friendships", "users", column: "follower_id"
  add_foreign_key "sleep_trackings", "users"
end
