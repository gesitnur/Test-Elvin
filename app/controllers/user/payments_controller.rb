# frozen_string_literal: true

class User::PaymentsController < User::BaseCrudController
  before_action :form_collection, only: %i[new edit create update]
  before_action :find_invoice, only: %i[new edit create update]

  def create
    @transaction = Transaction.income.new
    @transaction.transaction_date = params[:payment_date]
    @transaction.amount = params[:amount_received].tr(',', '').to_f
    @transaction.description = params[:description]
    @transaction.cash_book_id = params[:deposit_to]
    @transaction.cash_book_category_id = params[:category]
    @transaction.is_editable = false
    @transaction.save

    @payment = @transaction.build_payment
    @payment.payment_mode = params[:payment_mode] || @payment.payment_mode
    @payment.payment_date = params[:payment_date]
    @payment.amount_received = params[:amount_received].tr(',', '').to_f
    @payment.description = params[:description]
    @payment.currency = @transaction.cash_book.currency
    @payment.payment_transaction = @transaction
    @payment.invoice_id = params[:invoice_id]
    @payment.save

    if params[:payment_mode].blank?
      @invoice.pay
    end

    if @transaction.errors.present? || @payment.errors.present?
      flash[:alert] = (@transaction.errors.full_messages + @payment.errors.full_messages).uniq
      render 'new'
    else
      flash[:notice] = 'Payment successfully created.'
      redirect_to user_invoices_path
    end
  end

  def update
    @transaction = @payment.payment_transaction
    @transaction.transaction_type = 'Income'
    @transaction.transaction_date = params[:payment_date]
    @transaction.amount = params[:amount_received].tr(',', '').to_f
    @transaction.description = params[:description]
    @transaction.cash_book_id = params[:deposit_to]
    @transaction.cash_book_category_id = params[:category]
    @transaction.is_editable = false
    @transaction.save

    @payment.payment_mode = params[:payment_mode] || @payment.payment_mode
    @payment.payment_date = params[:payment_date]
    @payment.amount_received = params[:amount_received].tr(',', '').to_f
    @payment.description = params[:description]
    @payment.currency = @transaction.cash_book.currency
    @payment.save

    if params[:payment_mode].blank?
      @invoice.pay
    end

    if @transaction.errors.present? || @payment.errors.present?
      flash[:alert] = (@transaction.errors.full_messages + @payment.errors.full_messages).uniq
      render 'edit'
    else
      flash[:notice] = 'Payment successfully updated.'
      redirect_to user_invoices_path
    end
  end

  private

  def form_collection
    @cash_books = cash_book_select_options(CashBook.all, { label: %i[name], value: :id })
    @categories = build_select_options(CashBookCategory.income, { label: %i[name], value: :id })
    @currencies = build_select_options(Currency.approved, { label: %i[code], value: :id })
    @types = Payment.payment_modes.keys.to_a
  end

  def find_invoice
    @invoice = Invoice.find(params[:invoice_id])
  end
end
