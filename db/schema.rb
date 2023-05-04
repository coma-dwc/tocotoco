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

ActiveRecord::Schema.define(version: 2023_05_04_104022) do

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

  create_table "article_hashtags", id: false, force: :cascade do |t|
    t.integer "article_id_id"
    t.integer "hashtag_id_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id_id"], name: "index_article_hashtags_on_article_id_id"
    t.index ["hashtag_id_id"], name: "index_article_hashtags_on_hashtag_id_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "place_id", null: false
    t.integer "hashtag_id"
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hashtag_id"], name: "index_articles_on_hashtag_id"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user"
    t.integer "article"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "\"user_id\", \"article_id\"", name: "index_bookmarks_on_user_id_and_article_id", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "article_id", null: false
    t.string "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hashtags", force: :cascade do |t|
    t.string "hashname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hashname"], name: "index_hashtags_on_hashname", unique: true
  end

  create_table "images", force: :cascade do |t|
    t.integer "article_id", null: false
    t.string "image_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "places", force: :cascade do |t|
    t.string "prefectures", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "todos", force: :cascade do |t|
    t.string "task", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_todos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.text "introduction"
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "article_hashtags", "article_ids"
  add_foreign_key "article_hashtags", "hashtag_ids"
  add_foreign_key "articles", "hashtags"
  add_foreign_key "todos", "users"
end
