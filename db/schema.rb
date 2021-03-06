# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_05_041048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "charges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "stripe_session_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "item_id", null: false
    t.index ["item_id"], name: "index_charges_on_item_id"
    t.index ["user_id"], name: "index_charges_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "lesson_reservation_id", null: false
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_reservation_id"], name: "index_feedbacks_on_lesson_reservation_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "amount", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amount"], name: "index_items_on_amount"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lesson_reservations", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "zoom_url", null: false
    t.bigint "lesson_ticket_id", null: false
    t.index ["lesson_id"], name: "index_lesson_reservations_on_lesson_id"
    t.index ["lesson_ticket_id"], name: "index_lesson_reservations_on_lesson_ticket_id"
  end

  create_table "lesson_tickets", force: :cascade do |t|
    t.bigint "charge_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["charge_id"], name: "index_lesson_tickets_on_charge_id"
    t.index ["user_id"], name: "index_lesson_tickets_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "language_id", null: false
    t.datetime "start_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_lessons_on_language_id"
    t.index ["teacher_id"], name: "index_lessons_on_teacher_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "lesson_reservation_id", null: false
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_reservation_id"], name: "index_notifications_on_lesson_reservation_id"
  end

  create_table "supported_languages", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "language_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_supported_languages_on_language_id"
    t.index ["teacher_id"], name: "index_supported_languages_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.text "profile"
    t.string "avatar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "charges", "items"
  add_foreign_key "charges", "users"
  add_foreign_key "feedbacks", "lesson_reservations"
  add_foreign_key "lesson_reservations", "lesson_tickets"
  add_foreign_key "lesson_reservations", "lessons"
  add_foreign_key "lesson_tickets", "charges"
  add_foreign_key "lesson_tickets", "users"
  add_foreign_key "lessons", "languages"
  add_foreign_key "lessons", "teachers"
  add_foreign_key "notifications", "lesson_reservations"
  add_foreign_key "supported_languages", "languages"
  add_foreign_key "supported_languages", "teachers"
end
