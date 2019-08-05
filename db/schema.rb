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

ActiveRecord::Schema.define(version: 2019_08_04_134028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "number_plan_entries", force: :cascade do |t|
    t.string "prefix"
    t.integer "max_length"
    t.integer "min_length"
    t.text "usage"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.tsvector "textsearchable_index_col"
    t.index ["textsearchable_index_col"], name: "index_number_plan_entries_on_textsearchable_index_col", using: :gin
  end

end
