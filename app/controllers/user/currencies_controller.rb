# frozen_string_literal: true

class User::CurrenciesController < User::BaseCrudController
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
  end

  def create
    super do
      self.redirect_path = user_currencies_path
    end
  end

  def update
    super do
      self.redirect_path = user_currencies_path
    end
  end

  private

  def form_collection
    @countries = build_select_options(Country.all)
  end
end
