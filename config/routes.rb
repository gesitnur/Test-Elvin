# frozen_string_literal: true

Rails.application.routes.draw do
  constraints DomainConstraint.new('nineod.com') do
    get '/', to: 'nineod/home#index'
    get '/website_builder', to: 'nineod/home#website_builder'
    get '/platform_builder', to: 'nineod/home#platform_builder'
    get '/custom_web_app', to: 'nineod/home#custom_web_app'
    get '/services', to: 'nineod/home#services'
    get '/links', to: 'nineod/home#links'
    get '/contact_request', to: 'nineod/home#contact_request'
  end

  constraints DomainConstraint.new('nineodfreight.com') do
    get '/', to: 'nineod_freight/home#index'
    get '/about_us', to: 'nineod_freight/home#about_us'
    get '/service', to: 'nineod_freight/home#service'
    get '/contact', to: 'nineod_freight/home#contact'
  end

  constraints DomainConstraint.new('elvin.co.id') do
    devise_for :users, controllers: {
      sessions: 'user/devise/sessions',
      registrations: 'user/devise/registrations',
    }, :path => 'user'

    resources :users do
      member do
        get :confirm_email
      end
    end

    namespace :user do
      resources :dashboard, only: [:index] do
        collection do
          get :chart_dashboard
        end
      end
      resource :website_settings, only: [:edit, :update]
      resource :app_settings
      resources :positions do
        member do
          get :show_access_detail
        end
      end
      resources :users do 
        member do
          patch :reset_password
          get :generate_work_leave_link
          patch :approve_leave_request
          patch :reject_leave_request
          patch :allow_edit_leave_request
          delete :destroy_leave_request
          get :attendances
          post :set_attendance_in
          post :set_attendance_out
        end
      end
      resources :calendars do
        collection do
          get :get_holidays
          get :download_template
          get :leave_modal
          post :import_holiday
        end
      end
      resources :items
      resources :salary_slips
      resources :customers
      resources :tax_rates
      resources :sales_persons
      resources :payment_terms
      resources :help_centers
      resources :forum_replies do
        member do
          patch :vote
          get :sort
        end
      end
      namespace :help do
        resources :questions do
          member do
            patch :upvote
            get :count_view
          end
        end
      end
      resources :bug_reports
      resources :work_leave_requests do
        member do
          patch :approve
          patch :reject
          patch :allow_edit
        end
      end
      resources :attendances do
        member do
          post :attendance_in
          post :attendance_out
          post :overtime_in
          post :overtime_out
        end
      end
      resources :currencies do
        collection do
          get :find_country
        end
      end
      resources :cash_books do
        member do
          patch :set_default
        end
      end
      resources :recurrings
      resources :debts
      resources :cash_reports do
        collection do
          get :daily
          get :daily_expense
          get :daily_transfer
          get :monthly
          get :monthly_expense
          get :monthly_transfer
          get :weekly
          get :weekly_expense
          get :weekly_transfer
          get :annually
          get :annually_expense
          get :annually_transfer
        end
      end
      resources :leave_types
      resources :projects do
        member do
          get :list_user
          post :select_user
          delete :destroy_user
        end
      end
      resources :company_holidays
      resources :debt_items
      resources :credits
      resources :credit_items
      resources :cash_book_categories
      resources :transactions do
        collection do
          get :transfer
          post :save_transfer
          get :category_collection
          get :cash_book
          get '/cash_book/:cash_book_id', to: 'transactions#index', as: :index
          get :find_cash_book
          get :find_recurring
          delete :destroy_transfer
        end
        member do
          get :edit_transfer
          patch :update_transfer
        end
      end
      resource :app_settings
      resources :surveys
      resources :invoices do
        collection do
          get :find_billing_address
          get :find_invoice_item
          get :find_tax_rate
          get :find_term
          get :item_collection
          get :find_currency
        end
        resources :payments
        member do
          get :export_pdf
        end
      end
      resources :interviews do 
        member do
          get :evaluate_answers
          get '/:gameplay_id/evaluate_answers', to: 'interviews#evaluate_answers', as: 'admin_evaluate_answers'
          post :evaluateeee
        end
      end
      resources :gameplays
    end

    namespace :interview do
      get '/:interview_id', to: 'interviews#quest', as: 'new_answers'
      get '/:gameplay_id/:interview_id/expert', to: 'interviews#expert', as: 'evaluate_answers'
      post '/answers', to: 'interviews#create_answer', as: 'answers'
      post '/evaluate_answers', to: 'interviews#evaluate_answer', as: 'create_evaluate'
    end

    get '/', to: 'home#index'
  end

  constraints SubdomainConstraint.new('admin') do
    get '/', to: 'admin/dashboard#dashboard'
    devise_for :admins, skip: [:registrations], controllers: {
      sessions: 'admin/devise/sessions'
    }, :path => ''


    namespace :admin, path: '' do
      resources :contact_requests
      resources :remaining_day_offs
      resources :survey_answers
      resources :surveys
      resources :help_centers do
        member do
          delete :destroy_reply
        end
      end
      resources :help_center_categories
      resources :bug_reports do
        member do
          patch :set_to_fixed
        end
      end
      resources :currencies do
        collection do
          get :find_country
        end
        member do
          patch :approve
          patch :reject
        end
      end
      resources :users do 
        member do
          patch :reset_password
          get :generate_work_leave_link
          patch :approve_leave_request
          patch :reject_leave_request
          patch :allow_edit_leave_request
          delete :destroy_leave_request
          get :attendances
          get :contract
          post :set_contract
          post :set_attendance_in
          post :set_attendance_out
          post :set_overtime_in
          post :set_overtime_out
          patch :set_pic
        end
      end
      resources :positions do
        member do
          get :show_access_detail
        end
      end
      resources :leave_types
      resources :attendances
      resources :projects do
        member do
          get :list_user
          post :select_user
          delete :destroy_user
        end
      end
      resources :work_leave_requests do
        member do
          patch :approve
          patch :reject
          patch :allow_edit
        end
      end
      resources :interviews do
        member do
          post :change_to_employee
        end
      end
      resources :gameplays
      resources :reports
      resources :admins do
        member do
          patch :reset_password
        end
      end
      get 'dashboard', to: 'dashboard#dashboard'
    end
  end

  constraints SubdomainConstraint.new('interview') do
    get '/', to: 'interview/dashboard#dashboard'
    devise_for :interviews, controllers: {
      sessions: 'interviews/devise/sessions'
    }, :path => 'interviews'
  end

  namespace :interviews, path: 'interviews' do
    resources :gameplays do
      member do
        get :quest
        get :quest_answer
        post :answer
      end
    end
  end

  resources :contact_requests

  get '/rails', to: 'rails/welcome#index'
  resources :work_leaves, only: [:index, :update] do
    collection do
      get :pending
      get :accepted
      get :rejected
      get :access_denied
      get :find_leave_type
      get '/:encrypted_code', to: 'work_leaves#employee_form', as: :form
    end
  end
end
