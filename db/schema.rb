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

ActiveRecord::Schema.define(version: 20160728022323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "project_macro_tasks", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "title",      default: "", null: false
    t.text     "notes"
    t.uuid     "created_by"
    t.uuid     "project_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["created_by"], name: "index_project_macro_tasks_on_created_by", using: :btree
    t.index ["project_id"], name: "index_project_macro_tasks_on_project_id", using: :btree
  end

  create_table "project_micro_task_break_points", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid     "worker_id"
    t.uuid     "project_micro_task_id"
    t.integer  "opened",                default: 0, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["project_micro_task_id"], name: "index_project_micro_task_break_points_on_project_micro_task_id", using: :btree
    t.index ["worker_id"], name: "index_project_micro_task_break_points_on_worker_id", using: :btree
  end

  create_table "project_micro_tasks", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "title",                 default: "", null: false
    t.text     "notes"
    t.integer  "level",                 default: 1,  null: false
    t.uuid     "project_macro_task_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["project_macro_task_id"], name: "index_project_micro_tasks_on_project_macro_task_id", using: :btree
  end

  create_table "projects", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "title",      default: "", null: false
    t.text     "notes"
    t.date     "begin_at",                null: false
    t.date     "finish_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "worker_tokens", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "code",       default: "", null: false
    t.datetime "expire_at"
    t.uuid     "worker_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["code"], name: "index_worker_tokens_on_code", unique: true, using: :btree
    t.index ["worker_id"], name: "index_worker_tokens_on_worker_id", using: :btree
  end

  create_table "workers", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.string   "email",      default: "", null: false
    t.string   "password",   default: "", null: false
    t.integer  "role",       default: 0,  null: false
    t.integer  "status",     default: 0,  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["email"], name: "index_workers_on_email", unique: true, using: :btree
  end

  create_table "workers_project_micro_tasks", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "worker_id"
    t.uuid "micro_task_id"
    t.index ["micro_task_id"], name: "index_workers_project_micro_tasks_on_micro_task_id", using: :btree
    t.index ["worker_id"], name: "index_workers_project_micro_tasks_on_worker_id", using: :btree
  end

  add_foreign_key "project_macro_tasks", "projects"
  add_foreign_key "project_macro_tasks", "workers", column: "created_by"
  add_foreign_key "project_micro_task_break_points", "project_micro_tasks"
  add_foreign_key "project_micro_task_break_points", "workers"
  add_foreign_key "project_micro_tasks", "project_macro_tasks"
  add_foreign_key "worker_tokens", "workers"
  add_foreign_key "workers_project_micro_tasks", "project_micro_tasks", column: "micro_task_id"
  add_foreign_key "workers_project_micro_tasks", "workers"
end
