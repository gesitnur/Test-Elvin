# frozen_string_literal: true

class User::TaxRatesController < User::BaseCrudController
  self.additional_parameters = [
    invoice_items_attributes: %i[id item_id name description qty rate tax_rate_id amount]
  ]

  def index
    @invoices = Invoice.get_invoices(current_user.company_id).order_desc.page(params[:page])
  end

  def create
    super do
      self.redirect_path = user_tax_rates_path
    end
  end

  def update
    super do
      self.redirect_path = user_tax_rates_path
    end
  end
end
