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

ActiveRecord::Schema.define(version: 20150509072644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "juegos_score"
    t.text     "genre",        default: [], array: true
    t.string   "platform"
    t.string   "release_date"
    t.string   "small_cover"
    t.string   "large_cover"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link"
    t.string   "developer"
    t.string   "publisher"
    t.string   "players"
    t.string   "duration"
    t.string   "language"
    t.string   "review_link"
    t.string   "game_type"
    t.string   "game_dlc"
    t.integer  "game_dlc_id"
  end

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "ownedgames", force: true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.string   "formato"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ownedgames", ["game_id"], name: "index_ownedgames_on_game_id", using: :btree
  add_index "ownedgames", ["user_id"], name: "index_ownedgames_on_user_id", using: :btree

  create_table "user_games", force: true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.string   "format"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_games", ["game_id"], name: "index_user_games_on_game_id", using: :btree
  add_index "user_games", ["user_id"], name: "index_user_games_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.datetime "confirmed_at"
    t.string   "unconfirmed_email"
    t.string   "profile_picture"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
