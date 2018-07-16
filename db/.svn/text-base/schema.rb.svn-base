# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101019211910) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",         :default => 0
    t.integer  "attempts",         :default => 0
    t.text     "handler"
    t.string   "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.string   "locked_by"
    t.datetime "failed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "first_started_at"
    t.datetime "last_started_at"
    t.datetime "finished_at"
    t.string   "machine"
  end

  create_table "labels", :force => true do |t|
    t.integer  "priority"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "machines", :force => true do |t|
    t.string   "name"
    t.integer  "status"
    t.integer  "qtp_resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "online"
  end

  create_table "priorities", :force => true do |t|
    t.string   "dbcode"
    t.string   "label"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qtp_logs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qtp_resources", :force => true do |t|
    t.string   "servername"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "dbcode"
    t.string   "label"
    t.string   "Email"
    t.integer  "delayed_job_id"
    t.string   "run_status"
    t.boolean  "EmailIncludeAll"
    t.string   "iface"
    t.integer  "priority"
    t.string   "run_from"
    t.string   "coverage"
  end

end
