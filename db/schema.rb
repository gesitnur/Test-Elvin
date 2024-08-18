# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_08_10_114024) do
  create_table "account_items", force: :cascade do |t|
    t.datetime "account_item_date"
    t.integer "account_item_type", default: 0
    t.string "type"
    t.float "amount", default: 0.0
    t.float "balance", default: 0.0
    t.text "description"
    t.integer "account_id"
    t.integer "cash_book_id"
    t.integer "cash_book_category_id"
    t.integer "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_initial", default: false
    t.index ["account_id"], name: "index_account_items_on_account_id"
    t.index ["cash_book_category_id"], name: "index_account_items_on_cash_book_category_id"
    t.index ["cash_book_id"], name: "index_account_items_on_cash_book_id"
    t.index ["transaction_id"], name: "index_account_items_on_transaction_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.datetime "account_date"
    t.integer "account_type", default: 0
    t.datetime "due_date"
    t.string "type"
    t.float "amount", default: 0.0
    t.float "balance", default: 0.0
    t.string "client"
    t.text "description"
    t.integer "currency_id"
    t.integer "cash_book_id"
    t.integer "cash_book_category_id"
    t.integer "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cash_book_category_id"], name: "index_accounts_on_cash_book_category_id"
    t.index ["cash_book_id"], name: "index_accounts_on_cash_book_id"
    t.index ["currency_id"], name: "index_accounts_on_currency_id"
    t.index ["transaction_id"], name: "index_accounts_on_transaction_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: ""
    t.string "login_uniq", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "domain_access"
    t.boolean "is_owner", default: false
    t.index ["email"], name: "index_admins_on_email"
    t.index ["login_uniq"], name: "index_admins_on_login_uniq", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "app_settings", force: :cascade do |t|
    t.string "company_name"
    t.string "company_logo_data"
    t.string "company_email"
    t.integer "industry"
    t.string "street1"
    t.string "street2"
    t.string "zip_code"
    t.string "phone"
    t.string "fax"
    t.string "website"
    t.text "term_and_condition"
    t.integer "fiscal_year"
    t.integer "start_date"
    t.string "report_basis"
    t.string "city"
    t.integer "state_id"
    t.integer "country_id"
    t.integer "currency_id"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "language_id"
    t.text "customer_note"
    t.text "working_day"
    t.index ["company_id"], name: "index_app_settings_on_company_id"
    t.index ["country_id"], name: "index_app_settings_on_country_id"
    t.index ["currency_id"], name: "index_app_settings_on_currency_id"
    t.index ["state_id"], name: "index_app_settings_on_state_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.text "attachment_data"
    t.string "attachment_type"
    t.integer "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_attachments_on_invoice_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "date", null: false
    t.datetime "checkin_time"
    t.datetime "checkout_time"
    t.datetime "overtime_start"
    t.datetime "overtime_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "billing_addresses", force: :cascade do |t|
    t.text "attention"
    t.text "street1"
    t.text "street2"
    t.text "zip_code"
    t.integer "phone"
    t.text "fax"
    t.string "city"
    t.integer "state_id"
    t.integer "country_id"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_billing_addresses_on_country_id"
    t.index ["customer_id"], name: "index_billing_addresses_on_customer_id"
    t.index ["state_id"], name: "index_billing_addresses_on_state_id"
  end

  create_table "bug_reports", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.integer "status"
    t.integer "user_id"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_bug_reports_on_company_id"
    t.index ["user_id"], name: "index_bug_reports_on_user_id"
  end

  create_table "cash_book_categories", force: :cascade do |t|
    t.integer "category_type"
    t.string "name"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_cash_book_categories_on_company_id"
  end

  create_table "cash_books", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "start_balance", default: 0.0
    t.float "current_balance", default: 0.0
    t.boolean "is_default"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "currency_id"
    t.index ["company_id"], name: "index_cash_books_on_company_id"
    t.index ["currency_id"], name: "index_cash_books_on_currency_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.integer "employee_range"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_holidays", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_holidays_on_company_id"
  end

  create_table "contact_requests", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.text "message"
    t.integer "domain_request"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "gaji_pokok"
    t.integer "tunjangan_jabatan"
    t.integer "tunjangan_makan"
    t.integer "tunjangan_transport"
    t.integer "tunjangan_laptop"
    t.integer "bpjs_kesehatan"
    t.integer "bpjs_ketenagakerjaan"
    t.integer "pph_21"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "periode_slip_gaji"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "currency_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "code"
    t.integer "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "symbol"
    t.integer "status", default: 0
    t.index ["country_id"], name: "index_currencies_on_country_id"
  end

  create_table "customers", force: :cascade do |t|
    t.integer "customer_type"
    t.integer "salutation"
    t.text "first_name"
    t.text "last_name"
    t.text "company_name"
    t.text "display_name"
    t.text "email"
    t.text "phone"
    t.text "website"
    t.string "facebook"
    t.string "twitter"
    t.text "tax_rate"
    t.boolean "enable_portal"
    t.integer "portal_language"
    t.text "bill_address"
    t.text "ship_address"
    t.text "remark"
    t.float "balance"
    t.integer "payment_term_id"
    t.integer "company_id"
    t.integer "currency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_customers_on_company_id"
    t.index ["currency_id"], name: "index_customers_on_currency_id"
    t.index ["payment_term_id"], name: "index_customers_on_payment_term_id"
  end

  create_table "forum_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forum_replies", force: :cascade do |t|
    t.text "message"
    t.integer "user_id"
    t.integer "forum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cached_votes_total", default: 0
    t.integer "cached_votes_score", default: 0
    t.integer "cached_votes_up", default: 0
    t.integer "cached_votes_down", default: 0
    t.integer "cached_weighted_score", default: 0
    t.integer "cached_weighted_total", default: 0
    t.float "cached_weighted_average", default: 0.0
    t.index ["forum_id"], name: "index_forum_replies_on_forum_id"
    t.index ["user_id"], name: "index_forum_replies_on_user_id"
  end

  create_table "forums", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "is_admin", default: false
    t.string "tag"
    t.string "slug"
    t.integer "user_id"
    t.integer "forum_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cached_votes_total", default: 0
    t.integer "cached_votes_score", default: 0
    t.integer "cached_votes_up", default: 0
    t.integer "cached_votes_down", default: 0
    t.integer "cached_weighted_score", default: 0
    t.integer "cached_weighted_total", default: 0
    t.float "cached_weighted_average", default: 0.0
    t.index ["forum_category_id"], name: "index_forums_on_forum_category_id"
    t.index ["user_id"], name: "index_forums_on_user_id"
  end

  create_table "gameplays", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "is_basic", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_gameplays_on_slug", unique: true
  end

  create_table "interview_answers", force: :cascade do |t|
    t.text "answer"
    t.integer "interview_id"
    t.integer "question_id"
    t.integer "gameplay_id"
    t.integer "point", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gameplay_id"], name: "index_interview_answers_on_gameplay_id"
    t.index ["interview_id"], name: "index_interview_answers_on_interview_id"
    t.index ["question_id"], name: "index_interview_answers_on_question_id"
  end

  create_table "interview_gameplays", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "status_scoring", default: 0
    t.float "total_score", default: 0.0
    t.integer "interview_id"
    t.integer "gameplay_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gameplay_id"], name: "index_interview_gameplays_on_gameplay_id"
    t.index ["interview_id"], name: "index_interview_gameplays_on_interview_id"
  end

  create_table "interviews", force: :cascade do |t|
    t.string "name"
    t.text "graduated"
    t.string "major"
    t.integer "gender"
    t.date "date_of_birth"
    t.integer "apply_for_job"
    t.string "domicile"
    t.string "phone_number"
    t.string "email"
    t.datetime "scheduled_interview"
    t.text "work_experience"
    t.boolean "is_training"
    t.integer "training_duration"
    t.boolean "fresh_graduated"
    t.boolean "is_trial"
    t.integer "trial_duration"
    t.text "hrd_notes"
    t.text "interview_link"
    t.text "notes_before_started"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "login_uniq"
    t.string "encrypted_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["encrypted_password"], name: "index_interviews_on_encrypted_password", unique: true
    t.index ["login_uniq"], name: "index_interviews_on_login_uniq", unique: true
  end

  create_table "invoice_items", force: :cascade do |t|
    t.integer "invoice_id"
    t.integer "item_id"
    t.string "name"
    t.text "description"
    t.integer "qty", default: 1
    t.float "rate", default: 0.0
    t.float "tax_amount", default: 0.0
    t.integer "tax_rate_id"
    t.float "amount", default: 0.0
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
    t.index ["item_id"], name: "index_invoice_items_on_item_id"
    t.index ["tax_rate_id"], name: "index_invoice_items_on_tax_rate_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "invoice_code"
    t.string "order_number"
    t.datetime "invoice_date"
    t.datetime "due_date"
    t.float "sub_total"
    t.float "discount_amount"
    t.float "discount_type"
    t.float "shipping_charge"
    t.float "adjusment"
    t.float "total"
    t.text "customer_notes"
    t.text "term_and_condition"
    t.integer "status", default: 0
    t.integer "customer_id"
    t.integer "sales_person_id"
    t.integer "payment_term_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "currency_id"
    t.text "customer_data"
    t.string "sales_person_name"
    t.index ["currency_id"], name: "index_invoices_on_currency_id"
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
    t.index ["payment_term_id"], name: "index_invoices_on_payment_term_id"
    t.index ["sales_person_id"], name: "index_invoices_on_sales_person_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "item_type"
    t.string "name"
    t.integer "unit"
    t.float "price"
    t.text "description"
    t.integer "tax_rate_id"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "currency_id"
    t.index ["company_id"], name: "index_items_on_company_id"
    t.index ["currency_id"], name: "index_items_on_currency_id"
    t.index ["tax_rate_id"], name: "index_items_on_tax_rate_id"
  end

  create_table "leave_types", force: :cascade do |t|
    t.string "name"
    t.boolean "is_active", default: true
    t.integer "leave_balance"
    t.integer "position"
    t.string "colour_code"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "priority", default: 0
    t.index ["company_id"], name: "index_leave_types_on_company_id"
  end

  create_table "payment_terms", force: :cascade do |t|
    t.string "name"
    t.integer "number_of_day"
    t.boolean "is_master", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "payment_mode", default: 0
    t.datetime "payment_date"
    t.text "description"
    t.float "amount_received", default: 0.0
    t.integer "currency_id"
    t.integer "invoice_id"
    t.integer "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_payments_on_currency_id"
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
    t.index ["transaction_id"], name: "index_payments_on_transaction_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "name"
    t.text "position_access"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position_type"
    t.index ["company_id"], name: "index_positions_on_company_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "punches", force: :cascade do |t|
    t.integer "punchable_id", null: false
    t.string "punchable_type", limit: 20, null: false
    t.datetime "starts_at", precision: nil, null: false
    t.datetime "ends_at", precision: nil, null: false
    t.datetime "average_time", precision: nil, null: false
    t.integer "hits", default: 1, null: false
    t.index ["average_time"], name: "index_punches_on_average_time"
    t.index ["punchable_type", "punchable_id"], name: "punchable_index"
  end

  create_table "questions", force: :cascade do |t|
    t.text "question"
    t.integer "question_type"
    t.string "option_1"
    t.string "option_2"
    t.string "option_3"
    t.string "option_4"
    t.integer "answer"
    t.text "hint_answer"
    t.integer "point"
    t.integer "gameplay_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gameplay_id"], name: "index_questions_on_gameplay_id"
  end

  create_table "recurrings", force: :cascade do |t|
    t.integer "recurring_type"
    t.float "amount", default: 0.0
    t.text "description"
    t.integer "transfer_from", default: 0
    t.integer "transfer_to", default: 0
    t.float "transfer_to_amount", default: 0.0
    t.float "transfer_from_amount", default: 0.0
    t.integer "cash_book_id"
    t.integer "cash_book_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "recurring_date"
    t.index ["cash_book_category_id"], name: "index_recurrings_on_cash_book_category_id"
    t.index ["cash_book_id"], name: "index_recurrings_on_cash_book_id"
  end

  create_table "remaining_day_offs", force: :cascade do |t|
    t.integer "remaining"
    t.integer "year"
  end

  create_table "sales_persons", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_sales_persons_on_company_id"
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.text "attention"
    t.text "street1"
    t.text "street2"
    t.text "zip_code"
    t.integer "phone"
    t.text "fax"
    t.string "city"
    t.integer "state_id"
    t.integer "country_id"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_shipping_addresses_on_country_id"
    t.index ["customer_id"], name: "index_shipping_addresses_on_customer_id"
    t.index ["state_id"], name: "index_shipping_addresses_on_state_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "survey_answers", force: :cascade do |t|
    t.text "answer"
    t.integer "survey_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_survey_answers_on_survey_id"
    t.index ["user_id"], name: "index_survey_answers_on_user_id"
  end

  create_table "survey_questions", force: :cascade do |t|
    t.string "question"
    t.text "description"
    t.integer "question_type"
    t.text "option"
    t.boolean "is_active"
    t.integer "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_survey_questions_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "period"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tax_rates", force: :cascade do |t|
    t.string "name"
    t.integer "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "transaction_type"
    t.datetime "transaction_date"
    t.float "amount", default: 0.0
    t.text "description"
    t.float "balance", default: 0.0
    t.integer "transfer_from", default: 0
    t.integer "transfer_to", default: 0
    t.integer "transfer_ref"
    t.integer "cash_book_id"
    t.integer "cash_book_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_start_balance", default: false
    t.boolean "is_editable", default: true
    t.boolean "is_recurring", default: false
    t.float "transfer_to_amount", default: 0.0
    t.float "transfer_from_amount", default: 0.0
    t.integer "recurring_date"
    t.index ["cash_book_category_id"], name: "index_transactions_on_cash_book_category_id"
    t.index ["cash_book_id"], name: "index_transactions_on_cash_book_id"
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.boolean "email_confirmed"
    t.string "confirm_token"
    t.integer "position_id"
    t.boolean "is_pic", default: false
    t.date "date_of_birth"
    t.string "domicile"
    t.integer "gender"
    t.text "graduated"
    t.string "phone_number"
    t.integer "leave_request_balance", default: 0
    t.text "address"
    t.string "nik"
    t.string "npwp"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["position_id"], name: "index_users_on_position_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter"
  end

  create_table "website_settings", force: :cascade do |t|
    t.string "coming_soon_title"
    t.text "coming_soon_description"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "pending_leave_request_message"
    t.text "accepted_leave_request_message"
    t.text "rejected_leave_request_message"
    t.index ["company_id"], name: "index_website_settings_on_company_id"
  end

  create_table "work_leave_requests", force: :cascade do |t|
    t.integer "leave_period"
    t.string "status"
    t.date "start_date"
    t.date "end_date"
    t.text "reason"
    t.boolean "is_editable", default: true
    t.integer "approved_by"
    t.text "encrypted_code"
    t.datetime "approval_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "reject_reason"
    t.integer "leave_type_id"
    t.integer "number_of_day"
    t.integer "replacement_user_id"
    t.index ["leave_type_id"], name: "index_work_leave_requests_on_leave_type_id"
    t.index ["user_id"], name: "index_work_leave_requests_on_user_id"
  end

  add_foreign_key "interview_answers", "gameplays"
  add_foreign_key "interview_answers", "interviews"
  add_foreign_key "interview_answers", "questions"
  add_foreign_key "interview_gameplays", "gameplays"
  add_foreign_key "interview_gameplays", "interviews"
end
