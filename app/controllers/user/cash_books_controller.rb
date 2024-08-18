# frozen_string_literal: true

class User::CashBooksController < User::BaseController
  include Modules::Crudable
  before_action :authenticate_user!
  layout 'owner_layout'
  before_action :form_collection, only: %i[new create edit update]
  self.order_field      = :is_default
  self.order_direction  = :desc

  def set_default
    CashBook.update(is_default: false)
    @cash_book = CashBook.find(params[:id])
    @cash_book.update(is_default: true)

    redirect_to user_cash_books_path
  end

  def create
    super do
      resource.start_balance = given_params[:start_balance].tr(',', '').to_f
      resource.current_balance = given_params[:start_balance].tr(',', '').to_f
      self.redirect_path = user_cash_books_path
    end
  end

  def update
    super do
      if params[:cash_book][:start_balance].present?
        params[:cash_book][:start_balance] = params[:cash_book][:start_balance].tr(',', '').to_f
        resource.update_start_balance_transaction(params[:cash_book][:start_balance])
        resource.current_balance = params[:cash_book][:start_balance]
      end
      self.redirect_path = user_cash_books_path
    end
  end

  private

  def form_collection
    @currencies = build_select_options(Currency.approved, { label: %i[code], value: :id })
  end
end
