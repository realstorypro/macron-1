class CreateDbStructure < ActiveRecord::Migration[5.2]
  def change
    create_table "ahoy_events", force: :cascade do |t|
      t.bigint "visit_id"
      t.bigint "user_id"
      t.string "name"
      t.jsonb "properties"
      t.datetime "time"
      t.index "properties jsonb_path_ops", name: "index_ahoy_events_on_properties_jsonb_path_ops", using: :gin
      t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
      t.index ["user_id"], name: "index_ahoy_events_on_user_id"
      t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
    end

    create_table "ahoy_visits", force: :cascade do |t|
      t.string "visit_token"
      t.string "visitor_token"
      t.bigint "user_id"
      t.string "ip"
      t.text "user_agent"
      t.text "referrer"
      t.string "referring_domain"
      t.string "search_keyword"
      t.text "landing_page"
      t.string "browser"
      t.string "os"
      t.string "device_type"
      t.string "country"
      t.string "region"
      t.string "city"
      t.string "utm_source"
      t.string "utm_medium"
      t.string "utm_term"
      t.string "utm_content"
      t.string "utm_campaign"
      t.datetime "started_at"
      t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
      t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
    end

    create_table "blazer_audits", force: :cascade do |t|
      t.bigint "user_id"
      t.bigint "query_id"
      t.text "statement"
      t.string "data_source"
      t.datetime "created_at"
      t.index ["query_id"], name: "index_blazer_audits_on_query_id"
      t.index ["user_id"], name: "index_blazer_audits_on_user_id"
    end

    create_table "blazer_checks", force: :cascade do |t|
      t.bigint "creator_id"
      t.bigint "query_id"
      t.string "state"
      t.string "schedule"
      t.text "emails"
      t.string "check_type"
      t.text "message"
      t.datetime "last_run_at"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["creator_id"], name: "index_blazer_checks_on_creator_id"
      t.index ["query_id"], name: "index_blazer_checks_on_query_id"
    end

    create_table "blazer_dashboard_queries", force: :cascade do |t|
      t.bigint "dashboard_id"
      t.bigint "query_id"
      t.integer "position"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["dashboard_id"], name: "index_blazer_dashboard_queries_on_dashboard_id"
      t.index ["query_id"], name: "index_blazer_dashboard_queries_on_query_id"
    end

    create_table "blazer_dashboards", force: :cascade do |t|
      t.bigint "creator_id"
      t.text "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["creator_id"], name: "index_blazer_dashboards_on_creator_id"
    end

    create_table "blazer_queries", force: :cascade do |t|
      t.bigint "creator_id"
      t.string "name"
      t.text "description"
      t.text "statement"
      t.string "data_source"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["creator_id"], name: "index_blazer_queries_on_creator_id"
    end

    create_table "categories", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "color_id"
      t.string "slug"
      t.string "description"
      t.index ["slug"], name: "index_categories_on_slug", unique: true
    end

    create_table "colors", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "comments", force: :cascade do |t|
      t.text "body"
      t.integer "commentable_id"
      t.string "commentable_type"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "user_id"
    end

    create_table "entries", force: :cascade do |t|
      t.string "type"
      t.string "name"
      t.string "slug"
      t.json "payload"
      t.integer "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "category_id"
      t.date "published_date"
      t.index ["slug"], name: "index_entries_on_slug"
      t.index ["type"], name: "index_entries_on_type"
      t.index ["user_id"], name: "index_entries_on_user_id"
    end

    create_table "events", force: :cascade do |t|
      t.string "name"
      t.string "slug"
      t.json "payload"
      t.integer "category_id"
      t.integer "user_id"
      t.date "start_date"
      t.date "end_date"
      t.date "published_date"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["category_id"], name: "index_events_on_category_id"
      t.index ["slug"], name: "index_events_on_slug"
      t.index ["user_id"], name: "index_events_on_user_id"
    end

    create_table "profiles", force: :cascade do |t|
      t.jsonb "payload"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "user_id"
    end

    create_table "roles", force: :cascade do |t|
      t.string "name"
      t.string "resource_type"
      t.bigint "resource_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
      t.index ["name"], name: "index_roles_on_name"
      t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
    end

    create_table "settings", force: :cascade do |t|
      t.json "payload"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "taggings", force: :cascade do |t|
      t.integer "tag_id"
      t.integer "taggable_id"
      t.string "taggable_type"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "tags", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "users", force: :cascade do |t|
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer "sign_in_count", default: 0, null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string "current_sign_in_ip"
      t.string "last_sign_in_ip"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "username"
      t.string "slug"
      t.integer "comments_count", default: 0
      t.string "phone_number"
      t.string "country"
      t.boolean "phone_verified", default: false, null: false
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
      t.index ["slug"], name: "index_users_on_slug", unique: true
      t.index ["username"], name: "index_users_on_username", unique: true
    end

    create_table "users_roles", id: false, force: :cascade do |t|
      t.bigint "user_id"
      t.bigint "role_id"
      t.index ["role_id"], name: "index_users_roles_on_role_id"
      t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
      t.index ["user_id"], name: "index_users_roles_on_user_id"
    end
  end
end
