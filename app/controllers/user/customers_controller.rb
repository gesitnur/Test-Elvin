# frozen_string_literal: true

class User::CustomersController < User::BaseCrudController
  before_action :find_customer, only: %i[show edit update destroy]
  before_action :form_collection, only: %i[new create edit update show]
  before_action :find_company
  self.additional_parameters = [
    billing_address_attributes: %i[id attention country_id street1 street2 address city state_id zip_code phone fax],
    shipping_address_attributes: %i[id attention country_id street1 street2 address city state_id zip_code phone fax]
  ]
  self.init_relations = {
    has_one: %i[billing_address shipping_address],
    has_many: %i[]
  }

  def index
    @customers = @customers.where(company: @company)
  end

  def show
    @invoices = @customer.invoices.order_desc.page(params[:page])
  end

  def destroy
    if @customer.destroy
      flash[:notice] = 'Customer Successfully Destroyed.'
    else
      flash[:alert] = @customer.errors.full_messages.to_sentence
    end

    redirect_to user_customers_path
  end

  def form_collection
    @tax_rates = build_select_options(TaxRate.all, { label: %i[name], value: :id })
    @payment_terms = build_select_options(PaymentTerm.without_custom_data, { label: %i[name], value: :id })
    @salutations = Customer.salutations.keys.to_a
    @currencies = build_select_options(Currency.approved, { label: %i[code], value: :id })
    @countries = build_select_options(Country.all)
    @states = build_select_options(State.all)
  end

  def find_customer
    @customer = Customer.find(params[:id])
  end

  def find_company
    @company = current_user.company
  end
end
