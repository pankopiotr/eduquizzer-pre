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

ActiveRecord::Schema.define(version: 20171207180248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attempts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "quiz_id"
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "piece_id"
    t.integer  "max_score"
    t.index ["quiz_id"], name: "index_attempts_on_quiz_id", using: :btree
    t.index ["user_id"], name: "index_attempts_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pieces", force: :cascade do |t|
    t.integer  "attempt_id"
    t.integer  "task_id"
    t.text     "randomized_solutions", default: [],              array: true
    t.text     "chosen_solutions",     default: [],              array: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["attempt_id"], name: "index_pieces_on_attempt_id", using: :btree
    t.index ["task_id"], name: "index_pieces_on_task_id", using: :btree
  end

  create_table "quizzes", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.boolean  "random"
    t.integer  "no_random_tasks"
    t.boolean  "used",            default: false
    t.integer  "time_limit"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "author_id"
    t.boolean  "archived",        default: false
    t.datetime "archived_at"
    t.boolean  "active",          default: false
    t.index ["author_id"], name: "index_quizzes_on_author_id", using: :btree
  end

  create_table "quizzes_tasks", id: false, force: :cascade do |t|
    t.integer "quiz_id"
    t.integer "task_id"
    t.index ["quiz_id"], name: "index_quizzes_tasks_on_quiz_id", using: :btree
    t.index ["task_id"], name: "index_quizzes_tasks_on_task_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.string   "task_type"
    t.string   "category"
    t.text     "description"
    t.string   "asset"
    t.text     "correct_solutions",               default: [],                 array: true
    t.text     "wrong_solutions",                 default: [],                 array: true
    t.integer  "score"
    t.boolean  "archived",                        default: false
    t.boolean  "random"
    t.integer  "no_random_solutions"
    t.integer  "min_no_random_correct_solutions"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "author_id"
    t.datetime "archived_at"
    t.boolean  "used",                            default: false
    t.index ["author_id"], name: "index_tasks_on_author_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "student_id"
    t.string   "cookie_digest"
    t.boolean  "admin",             default: false
    t.boolean  "active",            default: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.string   "reset_digest"
    t.datetime "reset_at"
  end

  add_foreign_key "quizzes", "users", column: "author_id"
  add_foreign_key "tasks", "users", column: "author_id"
end
