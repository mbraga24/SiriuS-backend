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

ActiveRecord::Schema.define(version: 2020_11_16_030234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "archive_documents", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.bigint "user_id", null: false
    t.bigint "archive_project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["archive_project_id"], name: "index_archive_documents_on_archive_project_id"
    t.index ["user_id"], name: "index_archive_documents_on_user_id"
  end

  create_table "archive_projects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "start_date"
    t.string "due_date"
    t.string "archived_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "archive_trees", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "archive_project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["archive_project_id"], name: "index_archive_trees_on_archive_project_id"
    t.index ["user_id"], name: "index_archive_trees_on_user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_documents_on_project_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "custom_invitation"
    t.string "company"
    t.integer "sender_id"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "project_trees", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_trees_on_project_id"
    t.index ["user_id"], name: "index_project_trees_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "start_date"
    t.string "due_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "job_title"
    t.boolean "available", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
  end

  add_foreign_key "archive_documents", "archive_projects"
  add_foreign_key "archive_documents", "users"
  add_foreign_key "archive_trees", "archive_projects"
  add_foreign_key "archive_trees", "users"
  add_foreign_key "documents", "projects"
  add_foreign_key "documents", "users"
  add_foreign_key "project_trees", "projects"
  add_foreign_key "project_trees", "users"
end
