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

ActiveRecord::Schema.define(version: 20170916125755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quizzes", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.string   "tasks",           default: [],              array: true
    t.boolean  "random"
    t.integer  "no_random_tasks"
    t.boolean  "used"
    t.integer  "time_limit"
    t.integer  "score"
    t.string   "author"
    t.string   "category"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
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
    t.boolean  "mathjax"
    t.boolean  "random"
    t.integer  "no_random_solutions"
    t.integer  "min_no_random_correct_solutions"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "author_id"
    t.datetime "archived_at"
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

  add_foreign_key "tasks", "users", column: "author_id"
end
