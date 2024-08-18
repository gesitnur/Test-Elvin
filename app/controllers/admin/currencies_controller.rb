# frozen_string_literal: true

class Admin::CurrenciesController < Admin::BaseCrudController
  before_action :form_collection, only: %i[new create edit update]

  def find_country
    @country = Country.find(params[:country_id])

    respond_to do |format|
      format.json { render json: { symbol: Money::Currency.new(@country.currency_code).symbol, code: @country.currency_code }, status: 200 }
      format.html
    end
  end

  def index
    @currencies = @currencies.approved
    @request_currencies = Currency.pending
  end

  def create
    super do
      self.redirect_path = admin_currencies_path
    end
  end

  def update
    super do
      self.redirect_path = admin_currencies_path
    end
  end

  def approve
    @currency = Currency.find(params[:id])

    if @currency.approved!
      flash[:notice] = 'Currency Successfully Approved.'
    else
      flash[:alert] = @customer.errors.full_messages.to_sentence
    end

    redirect_to admin_currencies_path
  end

  def reject
    @currency = Currency.find(params[:id])

    if @currency.destroy
      flash[:notice] = 'Currency Successfully Rejected.'
    else
      flash[:alert] = @customer.errors.full_messages.to_sentence
    end

    redirect_to admin_currencies_path
  end

  private

  def form_collection
    @countries = build_select_options(Country.all)
  end
end
