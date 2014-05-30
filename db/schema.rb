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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140517063828) do

  create_table "admins", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "barn_configurations", :force => true do |t|
    t.integer  "building_temperature"
    t.boolean  "water_sensor_reset"
    t.boolean  "propane_sensor_reset"
    t.integer  "location_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "barn_managers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "barn_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "barns", :force => true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "total_pigs",  :default => 0
  end

  create_table "brooder_heater_states", :force => true do |t|
    t.integer "reading_id"
    t.string  "status"
  end

  create_table "controller_admins", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "barn_id"
  end

  create_table "curtain_controls", :force => true do |t|
    t.integer  "curtain"
    t.string   "action"
    t.integer  "location_configuration_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "curtain_states", :force => true do |t|
    t.integer "reading_id"
    t.string  "status"
  end

  create_table "event_reports", :force => true do |t|
    t.integer  "input_value"
    t.integer  "output_value"
    t.integer  "event_code"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "barn_id"
  end

  create_table "farm_owners", :force => true do |t|
    t.integer  "user_id"
    t.integer  "farm_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "farms", :force => true do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "hog_owner_id"
  end

  create_table "heater_controls", :force => true do |t|
    t.integer  "heater"
    t.string   "action"
    t.string   "mode"
    t.integer  "period"
    t.integer  "location_configuration_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "hog_owners", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "inventory_reports", :force => true do |t|
    t.integer  "barn_id"
    t.date     "report_date"
    t.string   "user_initials"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "ir_feeds", :force => true do |t|
    t.integer "reading_id"
    t.string  "status"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.integer  "farm_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "mobile_carriers", :force => true do |t|
    t.string   "name"
    t.string   "email_to_sms"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "pictures", :force => true do |t|
    t.integer  "farm_id"
    t.string   "caption"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "pig_deaths", :force => true do |t|
    t.integer "inventory_report_id"
    t.string  "cause"
    t.integer "count"
  end

  create_table "pig_treatments", :force => true do |t|
    t.integer "inventory_report_id"
    t.string  "medicine_given"
    t.string  "dosage"
    t.string  "how_administered"
    t.integer "count"
  end

  create_table "readings", :force => true do |t|
    t.integer  "humidity"
    t.integer  "water_total"
    t.integer  "propane_total"
    t.string   "air_quality"
    t.datetime "reported_at"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "system_status"
    t.string   "CO"
    t.string   "AC_power"
    t.integer  "barn_id"
  end

  create_table "shipments", :force => true do |t|
    t.integer  "barn_id"
    t.date     "shipment_date"
    t.integer  "total_pigs"
    t.integer  "total_doa"
    t.string   "pig_supplier"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "site_managers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "temperatures", :force => true do |t|
    t.integer  "reading_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_devices", :force => true do |t|
    t.integer  "user_id"
    t.text     "regid"
    t.boolean  "is_active",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.string   "persistence_token"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "mobile_phone"
    t.boolean  "email_alerts_enabled"
    t.boolean  "text_alerts_enabled"
    t.integer  "mobile_carrier_id"
    t.boolean  "call_alerts_enabled"
  end

  create_table "vent_fan_controls", :force => true do |t|
    t.integer  "fan"
    t.integer  "speed"
    t.string   "mode"
    t.integer  "period"
    t.integer  "location_configuration_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "vent_fans", :force => true do |t|
    t.integer "reading_id"
    t.integer "value"
  end

  create_table "zone_temperatures", :force => true do |t|
    t.integer  "zone"
    t.integer  "temperature"
    t.integer  "barn_configuration_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

end
