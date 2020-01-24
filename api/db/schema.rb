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

ActiveRecord::Schema.define(version: 2020_01_20_230720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "artists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "collections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "username"
    t.uuid "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_collections_on_user_id"
    t.index ["username"], name: "index_collections_on_username", unique: true
  end

  create_table "collections_releases", id: false, force: :cascade do |t|
    t.uuid "collection_id"
    t.uuid "release_id"
    t.bigint "discogs_instance_id"
    t.index ["collection_id"], name: "index_collections_releases_on_collection_id"
    t.index ["discogs_instance_id"], name: "index_collections_releases_on_discogs_instance_id", unique: true
    t.index ["release_id"], name: "index_collections_releases_on_release_id"
  end

  create_table "releases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "artist"
    t.jsonb "discogs_response"
    t.bigint "discogs_release_id"
    t.datetime "imported_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discogs_release_id"], name: "index_releases_on_discogs_release_id"
  end

  create_table "releases_users", id: false, force: :cascade do |t|
    t.uuid "release_id"
    t.uuid "user_id"
    t.index ["release_id", "user_id"], name: "index_releases_users_on_release_id_and_user_id", unique: true
    t.index ["release_id"], name: "index_releases_users_on_release_id"
    t.index ["user_id"], name: "index_releases_users_on_user_id"
  end

  create_table "tracks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "position"
    t.string "title"
    t.string "artist"
    t.jsonb "spotify_response"
    t.decimal "bpm"
    t.integer "duration"
    t.integer "key"
    t.datetime "imported_at"
    t.uuid "release_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["release_id"], name: "index_tracks_on_release_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "discogs_request_token"
    t.jsonb "discogs_access_token"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "collections", "users"
  add_foreign_key "collections_releases", "collections"
  add_foreign_key "collections_releases", "releases"
  add_foreign_key "releases_users", "releases"
  add_foreign_key "releases_users", "users"
  add_foreign_key "tracks", "releases"
end
