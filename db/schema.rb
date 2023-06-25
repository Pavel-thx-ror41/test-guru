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

ActiveRecord::Schema.define(version: 2023_06_25_215007) do

  create_table "answers", force: :cascade do |t|
    t.integer "question_id", null: false
    t.string "title", limit: 30, null: false
    t.boolean "correct"
    t.text "info", limit: 512
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["title"], name: "index_answers_on_title", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "title", limit: 30, null: false
    t.text "info", limit: 512
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_categories_on_title", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.integer "test_id", null: false
    t.string "title", limit: 30, null: false
    t.text "info", limit: 512
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["test_id"], name: "index_questions_on_test_id"
    t.index ["title"], name: "index_questions_on_title", unique: true
  end

  create_table "tests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "category_id", null: false
    t.boolean "published"
    t.string "title", limit: 30, null: false
    t.text "info", limit: 512
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "level", default: 1, null: false
    t.index ["category_id"], name: "index_tests_on_category_id"
    t.index ["title"], name: "index_tests_on_title", unique: true
    t.index ["user_id"], name: "index_tests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 30, null: false
    t.string "name", limit: 30, null: false
    t.string "password_digest", null: false
    t.string "password_reset_token"
    t.text "info", limit: 512
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["password_reset_token"], name: "index_users_on_password_reset_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "questions", "tests"
  add_foreign_key "tests", "categories"
  add_foreign_key "tests", "users"
end