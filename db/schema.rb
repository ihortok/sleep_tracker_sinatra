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

ActiveRecord::Schema.define(version: 2021_09_27_200649) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "babies", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.datetime "date_of_birth"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "night_sleep_start"
    t.integer "night_sleep_finish"
    t.index ["user_id"], name: "index_babies_on_user_id"
  end

  create_table "baby_params", force: :cascade do |t|
    t.integer "weight"
    t.integer "height"
    t.datetime "measurement_date"
    t.bigint "baby_id"
    t.datetime "created_at", precision: 6, null: false
    t.index ["baby_id"], name: "index_baby_params_on_baby_id"
  end

  create_table "feedings", force: :cascade do |t|
    t.datetime "started_at"
    t.datetime "finished_at"
    t.bigint "baby_id"
    t.integer "status"
    t.integer "breast"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["baby_id"], name: "index_feedings_on_baby_id"
  end

  create_table "sleeps", force: :cascade do |t|
    t.datetime "started_at"
    t.datetime "finished_at"
    t.bigint "baby_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.index ["baby_id"], name: "index_sleeps_on_baby_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "country"
    t.string "time_zone"
  end

end
