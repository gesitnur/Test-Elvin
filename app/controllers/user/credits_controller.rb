# frozen_string_literal: true

class User::CreditsController < User::BaseCrudController
  before_action :form_collection, only: %i[new create edit update]

  def create
    super do
      resource.amount = given_params[:amount].tr(',','').to_f
      resource.create_transaction('Expense', "New credit to #{resource.client}", given_params[:cash_book_id])
      resource.create_account_item('CreditItem')
    end
  end

  def update
    super do
      if given_params[:cash_book_id].blank? || resource.cash_book_id != given_params[:cash_book_id].to_i
        resource.account_transaction.destroy if resource.account_transaction.present?
        resource.transaction_id = nil
      end
      params[:credit][:amount] = params[:credit][:amount].tr(',','').to_f
      resource.balance = given_params[:amount]
      resource.amount = given_params[:amount]
      resource.create_transaction('Expense', "New credit to #{given_params[:client]}", given_params[:cash_book_id])
      resource.create_account_item('CreditItem')
      resource.calculate_balance
    end
  end

  private

  def form_collection
    @currencies = build_select_options(Currency.approved, { label: %i[code], value: :id })
    @cash_books = build_select_options(CashBook.all, { label: %i[name], value: :id })
    @income_categories = build_select_options(CashBookCategory.expense, { label: %i[name], value: :id })
    # render plain: @currencies.inspect
  end
end
