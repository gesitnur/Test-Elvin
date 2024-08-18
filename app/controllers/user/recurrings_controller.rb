# frozen_string_literal: true

class User::RecurringsController < User::BaseCrudController
  before_action :form_collection, only: %i[new create edit update]
  self.model_resource = :transaction

  def index
    @transactions = @transactions.recurring
  end

  def create
    super do
      flash[:alert] = nil
      flash[:notice] = 'Recurring successfully created.'
      resource.amount = given_params[:amount].tr(',', '').to_f
      resource.transfer_to_amount = given_params[:transfer_to_amount].tr(',', '').to_f
      resource.transfer_from_amount = given_params[:transfer_from_amount].tr(',', '').to_f
    end
  end

  def update
    super do
      flash[:alert] = nil
      flash[:notice] = 'Recurring successfully updated.'
      params[:transaction][:amount] = params[:transaction][:amount].tr(',', '').to_f
      params[:transaction][:transfer_to_amount] = params[:transaction][:transfer_to_amount].tr(',', '').to_f
      params[:transaction][:transfer_from_amount] = params[:transaction][:transfer_from_amount].tr(',', '').to_f
    end
  end

  private

  def form_collection
    @categories = build_select_options(CashBookCategory.expense, { label: %i[name], value: :id })
    @types = Recurring.recurring_types.keys.to_a
    @dates = (1..31).to_a
    @cash_books = cash_book_select_options(CashBook.all, { label: %i[name], value: :id })
  end
end
