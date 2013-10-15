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

ActiveRecord::Schema.define(version: 20131015193025) do

  create_table "proyectos", force: true do |t|
    t.string   "nombre"
    t.string   "lugar"
    t.string   "descripcion_corta"
    t.text     "descripcion_larga"
    t.date     "fecha_inicio_proyecto"
    t.date     "fecha_fin_proyecto"
    t.datetime "fecha_inicio_recaudacion"
    t.datetime "fecha_fin_recaudation"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
