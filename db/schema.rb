# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130730151112) do

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "submission_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["submission_id"], name: "index_comments_on_submission_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "source_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "news_items", force: true do |t|
    t.integer  "user_id"
    t.string   "kind"
    t.string   "headline"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", force: true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "single_use_logins", force: true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "single_use_logins", ["token"], name: "index_single_use_logins_on_token", using: :btree

  create_table "single_use_notices", force: true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.string   "type"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "single_use_notices", ["user_id"], name: "index_single_use_notices_on_user_id", using: :btree

  create_table "submissions", force: true do |t|
    t.integer  "user_id"
    t.string   "kind"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "length"
    t.integer  "votes_count",                            default: 0
    t.integer  "comments_count",                         default: 0
    t.decimal  "rating",         precision: 4, scale: 2, default: 0.0
    t.datetime "last_vote"
    t.datetime "last_comment"
  end

  add_index "submissions", ["kind"], name: "index_submissions_on_kind", using: :btree
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "user_preferences", force: true do |t|
    t.integer  "user_id"
    t.string   "theme"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_preferences", ["user_id"], name: "index_user_preferences_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",                                     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "submissions_count",                         default: 0
    t.decimal  "average_rating",    precision: 4, scale: 2, default: 0.0
    t.datetime "last_login"
    t.boolean  "email_verified",                            default: false
    t.datetime "previous_login"
  end

  add_index "users", ["admin"], name: "index_users_on_admin", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

  create_table "verification_tokens", force: true do |t|
    t.integer "user_id"
    t.string  "token"
  end

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "submission_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["submission_id"], name: "index_votes_on_submission_id", using: :btree

end
