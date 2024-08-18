# frozen_string_literal: true

class User::ItemsController < User::BaseCrudController
  before_action :form_collection, only: %i[new create edit update show]

  def index
    @items = current_user.company.items.order_desc.page(params[:page])
  end

  def new
    @item = current_user.company.items.new
  end

  def create
    super do
      resource.price = given_params[:price].tr(',', '').to_f
    end
  end

  def update
    super do
      params[:item][:price] = params[:item][:price].tr(',', '').to_f
    end
  end

  private

  def form_collection
    customer_currencies = Customer.all.map(&:currency).uniq
    customer_currencies.push(app_setting.currency)
    @currencies = build_select_options(customer_currencies, { label: %i[code], value: :id })
    @tax_rates = build_select_options(TaxRate.all, { label: %i[name], value: :id })
    @units = Item.units.keys.to_a
  end
end
