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

ActiveRecord::Schema.define(:version => 20130627211329) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "audio_albums", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "post_id"
  end

  create_table "audio_files", :force => true do |t|
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "audio_album_id"
    t.hstore   "aws_urls"
    t.string   "name"
  end

  create_table "businesses", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "business_name"
    t.string   "business_banner"
    t.string   "business_logo"
    t.integer  "feed_id"
    t.string   "phone"
    t.string   "street_address"
    t.string   "state"
    t.string   "zip_code"
    t.string   "city"
  end

  add_index "businesses", ["email"], :name => "index_businesses_on_email", :unique => true
  add_index "businesses", ["reset_password_token"], :name => "index_businesses_on_reset_password_token", :unique => true

  create_table "feed_banners", :force => true do |t|
    t.integer  "feed_id"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "active"
  end

  create_table "feed_videos", :force => true do |t|
    t.integer  "feed_id"
    t.string   "video"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feeds", :force => true do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
    t.integer  "forecast_id"
    t.string   "time_zone"
  end

  create_table "forecasts", :force => true do |t|
    t.datetime "day_1_time"
    t.integer  "day_1_low"
    t.integer  "day_1_high"
    t.string   "day_1_icon"
    t.datetime "day_2_time"
    t.integer  "day_2_low"
    t.integer  "day_2_high"
    t.string   "day_2_icon"
    t.datetime "day_3_time"
    t.integer  "day_3_low"
    t.integer  "day_3_high"
    t.string   "day_3_icon"
    t.datetime "day_4_time"
    t.integer  "day_4_low"
    t.integer  "day_4_high"
    t.string   "day_4_icon"
    t.datetime "day_5_time"
    t.integer  "day_5_low"
    t.integer  "day_5_high"
    t.string   "day_5_icon"
    t.datetime "day_6_time"
    t.integer  "day_6_low"
    t.integer  "day_6_high"
    t.string   "day_6_icon"
    t.datetime "day_7_time"
    t.integer  "day_7_low"
    t.integer  "day_7_high"
    t.string   "day_7_icon"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "feed_id"
  end

  create_table "interests", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "landscape_photos", :force => true do |t|
    t.string   "caption"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "photo"
  end

  create_table "page_links", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.text     "image_url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "url"
    t.integer  "post_id"
  end

  create_table "page_links_posts", :id => false, :force => true do |t|
    t.integer "page_link_id"
    t.integer "post_id"
  end

  create_table "panda_uploads", :force => true do |t|
    t.boolean  "ready"
    t.string   "panda_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "post_id"
    t.string   "media_type"
  end

  create_table "photo_albums", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
    t.integer  "post_id"
  end

  create_table "portrait_photos", :force => true do |t|
    t.string   "caption"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "photo"
  end

  create_table "post_categories", :force => true do |t|
    t.string   "name"
    t.string   "helper"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.text     "content"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "feed_id"
    t.integer  "user_id"
    t.integer  "post_category_id"
    t.boolean  "promotional"
    t.boolean  "has_video"
    t.boolean  "has_audio"
    t.boolean  "has_photos"
    t.boolean  "has_links"
    t.hstore   "panda_meta"
    t.boolean  "ready"
    t.float    "promo_price"
    t.float    "promo_discounted_price"
    t.text     "promo_description"
    t.string   "promo_street_address"
    t.string   "promo_city"
    t.string   "promo_state"
    t.string   "promo_zip"
    t.string   "promo_labor_characteristic"
    t.boolean  "promo_free"
    t.float    "promo_wage"
    t.string   "promo_wage_time"
    t.float    "promo_shipping_cost"
    t.string   "promo_href"
    t.string   "promo_image"
    t.string   "promo_name"
    t.integer  "business_id"
    t.date     "promo_start_date"
    t.date     "promo_end_date"
    t.string   "promo_contact_email"
    t.string   "promo_type"
  end

  create_table "square_photos", :force => true do |t|
    t.string   "caption"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "photo"
    t.integer  "photo_album_id"
    t.integer  "user_id"
  end

  create_table "suitcases", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.hstore   "posts"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "username"
    t.integer  "interest_id"
    t.date     "birthday"
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar"
    t.string   "remember_me_token"
    t.integer  "feed_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "video_albums", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "post_id"
  end

  create_table "video_files", :force => true do |t|
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "video_album_id"
    t.hstore   "aws_urls"
  end

end
