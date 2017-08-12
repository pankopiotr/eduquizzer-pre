ActiveRecord::Schema.define(version: 20170724181908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password"
    t.string   "email"
    t.string   "student_id"
    t.string   "cookie_digest"
    t.boolean  "admin",         default: false
    t.boolean  "active",        default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

end
