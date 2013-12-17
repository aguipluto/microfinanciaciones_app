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

ActiveRecord::Schema.define(version: 20131215164026) do

  create_table "attachments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "proyecto_id"
  end

  create_table "cart_items", force: true do |t|
    t.integer  "proyecto_id"
    t.integer  "user_id"
    t.integer  "cart_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "aportacion",  precision: 6, scale: 2, default: 0.0, null: false
  end

  create_table "carts", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "purchased_at"
  end

  create_table "order_transactions", force: true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "orders", force: true do |t|
    t.integer  "cart_id"
    t.string   "ip_address"
    t.string   "cart_type"
    t.date     "card_expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "express_token"
    t.string   "express_payer_id"
    t.string   "first_name"
    t.string   "second_name"
    t.integer  "user_id"
  end

  create_table "payment_notifications", force: true do |t|
    t.text     "params"
    t.integer  "cart_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proyectos", force: true do |t|
    t.string   "titulo"
    t.string   "lugar"
    t.date     "fecha_inicio"
    t.date     "fecha_fin"
    t.string   "descripcion_corta"
    t.text     "descripcion_larga"
    t.decimal  "cantidad_total",      precision: 6, scale: 2, default: 0.0, null: false
    t.datetime "inicio_aportaciones"
    t.datetime "fin_aportaciones"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "family_name"
    t.date     "birthdate"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
