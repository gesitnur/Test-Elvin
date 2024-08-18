# frozen_string_literal: true

class User::TransactionsController < User::BaseCrudController
  before_action :form_collection, only: %i[new create edit update]
  self.order_field      = :transaction_date
  self.order_direction  = :asc

  def index
    params[:month] ||= Date.today.month
    params[:year] ||= Date.today.year
    @cash_book = CashBook.find(params[:cash_book_id])
    @transactions = @transactions.not_recurring.where(cash_book: params[:cash_book_id]).where(transaction_date: Time.new(params[:year].to_i, params[:month].to_i).all_month)

    year_to = if Date.today.year >= params[:year].to_i
                Date.today.year
              else
                Date.new(params[:year].to_i).year
              end

    @months = Date::MONTHNAMES.drop(1).each_with_index.collect { |m, i| [m, i + 1] }
    @years = (Date.new(params[:year].to_i).years_ago(4).year..year_to).to_a
  end

  def new
    @cash_book = CashBook.find(params[:cash_book_id])
    @transaction = @cash_book.transactions.new
  end

  def edit
    @cash_book = CashBook.find(params[:cash_book_id])
  end

  def create
    # render plain: set_variable(resources_name, load_resources).inspect
    super do
      flash[:alert] = nil
      resource.amount = given_params[:amount].tr(',', '').to_f
      @income_categories = build_select_options(CashBookCategory.income, { label: %i[id], value: :id })
      @expense_categories = build_select_options(CashBookCategory.expense, { label: %i[id], value: :id })
    end
  end

  def update
    super do
      params[:transaction][:amount] = params[:transaction][:amount].tr(',', '').to_f
      flash[:alert] = nil
      resource.amount = given_params[:amount]
      resource.save(validate: false)

      @cash_book = CashBook.find(given_params[:cash_book_id])
      @cash_book.update_balance2
      @cash_book.save
    end
  end

  def destroy
    super do
      self.redirect_path = user_transactions_path(cash_book_id: params[:cash_book_id])
    end
  end

  def category_collection
    @categories = CashBookCategory.where(category_type: params[:type])
    @category = params[:category]
  end

  def transfer
    @cash_book = CashBook.find(params[:cash_book_id])
    @recurring_transfers = build_select_options(Transaction.recurring.where(transaction_type: 'Transfer'), { label: %i[description], value: :id })
    @transaction = Transaction.new
    @cash_books = build_select_options(CashBook.all, { label: %i[name], value: :id })
  end

  def edit_transfer
    @transaction = Transaction.find(params[:id])
    @recurring_transfers = build_select_options(Transaction.recurring.where(transaction_type: 'Transfer'), { label: %i[description], value: :id })
    @all_transaction = Transaction.where(transfer_ref: @transaction.transfer_ref)
    transfer_from = @transaction.transfer_from
    transfer_to = @transaction.transfer_to

    @transfer_from = @all_transaction.find_by_cash_book_id(transfer_from)
    @transfer_to = @all_transaction.find_by_cash_book_id(transfer_to)

    @cash_books = build_select_options(CashBook.all, { label: %i[name], value: :id })
  end

  def update_transfer
    params[:transaction][:amount] = given_params[:amount].tr(',', '').to_f
    params[:transaction][:transfer_to_amount] = given_params[:transfer_to_amount].tr(',', '').to_f
    params[:transaction][:transfer_from_amount] = given_params[:transfer_from_amount].tr(',', '').to_f

    @transactions = Transaction.where(transfer_ref: given_params[:transfer_ref])

    checks = [given_params[:transfer_from], given_params[:transfer_to]]
    @transactions.each_with_index do |transaction, key|
      params[:transaction][:cash_book_id] = checks[key]
      transaction.update(given_params)
      @cash_book = transaction.cash_book
      @cash_book.update_balance2
      @cash_book.save
    end
  end

  def save_transfer
    params[:transaction][:amount] = given_params[:amount].tr(',', '').to_f
    params[:transaction][:transfer_to_amount] = given_params[:transfer_to_amount].tr(',', '').to_f
    params[:transaction][:transfer_from_amount] = given_params[:transfer_from_amount].tr(',', '').to_f

    unique_ref = DateTime.now.to_i
    [given_params[:transfer_from], given_params[:transfer_to]].each do |field|
      transaction = Transaction.new(given_params)
      transaction.cash_book_id = field
      transaction.transaction_type = 'Transfer'
      transaction.transfer_ref = unique_ref
      transaction.save
    end
  end

  def destroy_transfer
    Transfer.delete_transfer(params[:transfer_ref])

    flash[:notice] ||= 'Transaction successfully destroyed.'
    redirect_to user_transactions_path(cash_book_id: params[:cash_book_id])
  end

  def find_cash_book
    @cash_book = CashBook.find(params[:cash_book_id])

    respond_to do |format|
      format.json { render json: @cash_book.to_json, status: 200 }
      format.html
    end
  end

  def find_recurring
    @recurring = Transaction.find(params[:recurring_id])

    respond_to do |format|
      format.json { render json: @recurring.to_json, status: 200 }
      format.html
    end
  end

  private

  def form_collection
    @recurring_expenses = build_select_options(Transaction.recurring.where(transaction_type: 'Expense'), { label: %i[description], value: :id })
    @recurring_transfers = build_select_options(Transaction.recurring.where(transaction_type: 'Transfer'), { label: %i[description], value: :id })
    @categories = build_select_options(CashBookCategory.all, { label: %i[name], value: :id })

    @income_categories = build_select_options(CashBookCategory.income, { label: %i[id], value: :id })
    @expense_categories = build_select_options(CashBookCategory.expense, { label: %i[id], value: :id })
  end
end
