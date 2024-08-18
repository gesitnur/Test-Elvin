# frozen_string_literal: true

class User::CreditItemsController < User::BaseCrudController
  before_action :form_collection, only: %i[new create edit update]
  # self.model_resource = 'account'
  self.order_field      = :id
  self.order_direction  = :asc

  def index
    # @credit_items = @credit_items.where(account: params[:credit_id]).order(account_item_date: :asc)
    @credit_items = CreditItem.where(account: params[:credit_id]).page(params[:page])
                  .order(is_initial: :desc).order(account_item_date: :asc)
    @credit = Credit.find(params[:credit_id])
  end

  def destroy
    super do
      self.redirect_path = user_credit_items_path(credit_id: params[:credit_id])
    end
  end

  def update
    super do
      params[:credit_item][:amount] = params[:credit_item][:amount].tr(',','').to_f
      if given_params[:cash_book_id].blank? || resource.cash_book_id != given_params[:cash_book_id].to_i
        resource.account_transaction.destroy if resource.account_transaction.present?
        resource.transaction_id = nil
      end
      resource.update(cash_book_id: given_params[:cash_book_id], amount: given_params[:amount])
      credit = Credit.find(given_params[:account_id])
      credit.calculate_balance
    end
  end

  def create
    super do
      resource.amount = given_params[:amount].tr(',','').to_f
      resource.save
      credit = Credit.find(given_params[:account_id])
      credit.calculate_balance
    end
  end

  private

  def form_collection
    @currencies = build_select_options(Currency.approved, { label: %i[code], value: :id })
    @cash_books = build_select_options(CashBook.all, { label: %i[name], value: :id })
    if params[:type].eql?('Income')
      @income_categories = build_select_options(CashBookCategory.income, { label: %i[name], value: :id })
    else
      @income_categories = build_select_options(CashBookCategory.expense, { label: %i[name], value: :id })
    end
    # render plain: @currencies.inspect
  end
end
