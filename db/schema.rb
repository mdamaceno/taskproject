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

ActiveRecord::Schema.define(version: 20160727033550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "macro_tasks", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "title",      default: "", null: false
    t.text     "notes"
    t.uuid     "created_by"
    t.uuid     "project_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["created_by"], name: "index_macro_tasks_on_created_by", using: :btree
    t.index ["project_id"], name: "index_macro_tasks_on_project_id", using: :btree
  end

  create_table "micro_tasks", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "title",         default: "", null: false
    t.text     "notes"
    t.integer  "level",         default: 1,  null: false
    t.uuid     "macro_task_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["macro_task_id"], name: "index_micro_tasks_on_macro_task_id", using: :btree
  end

  create_table "projects", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "title",      default: "", null: false
    t.text     "notes"
    t.date     "begin_at",                null: false
    t.date     "finish_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "workers", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.string   "email",      default: "", null: false
    t.string   "password",   default: "", null: false
    t.integer  "role",       default: 0,  null: false
    t.integer  "status",     default: 0,  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_foreign_key "macro_tasks", "projects"
  add_foreign_key "macro_tasks", "workers", column: "created_by"
  add_foreign_key "micro_tasks", "macro_tasks"
end
