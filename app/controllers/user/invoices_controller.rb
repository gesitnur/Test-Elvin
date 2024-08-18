# frozen_string_literal: true

class User::InvoicesController < User::BaseCrudController
  before_action :form_collection, only: %i[new create edit update]
  before_action :find_invoice, only: %i[export_pdf edit update destroy]
  self.additional_parameters = [
    invoice_items_attributes: %i[id item_id name description qty rate tax_rate_id amount tax_amount _destroy],
    attachments_attributes: %i[id attachment _destroy]
  ]

  def index
    params[:q] ||= {}

    if params[:date_filter].present?
      today_formated = Date.today.strftime('%d/%m/%Y')
      date_from_formated = (Date.today - params[:date_filter].to_i.days).strftime('%d/%m/%Y')
      params[:q][:invoice_date_between] = "#{date_from_formated} - #{today_formated}"
    end

    @invoices = @invoices.ransack({ invoice_date_between: params[:q][:invoice_date_between] }).result.page(params[:page])
    @paid_invoices = @invoices.paid
    @unpaid_invoices = @invoices.unpaid
    @overdue_invoices = @invoices.unpaid.where('due_date < ?', Date.today)

    @q = @invoices.ransack(params[:q])
    @invoices = @q.result.page(params[:page])
    authorize @invoices
  end

  def new
    if params[:invoice_id].present?
      @clone = Invoice.find(params[:invoice_id])
      @clone.invoice_code = nil
      @invoice = @clone.deep_clone include: [:invoice_items]
    else
      @invoice.invoice_items.new
    end

    # authorize @invoice
  end

  def export_pdf
    authorize @invoice
    @customer = @invoice.customer
    @services = @invoice.invoice_items

    invoice = render_to_string 'export_pdf', formats: [:html], layout: false
    pdf = Grover.new(invoice, format: 'A4', margin: { top: '40px', bottom: '40px' }, display_url: request.base_url).to_pdf
    send_data pdf, filename: 'Invoice PDF', type: 'application/pdf', disposition: 'inline'
  end

  def find_billing_address
    return unless params['customer_id'].present?

    @customer = Customer.find(params['customer_id'])
  end

  def find_invoice_item
    if params['item_id'].present?
      begin
        @item = Item.find(params['item_id'])
      rescue
        @item = Item.new(name: params['item_id'])
      end
    end

    respond_to do |format|
      format.json { render json: @item.to_json, status: 200 }
      format.html
    end
  end

  def find_tax_rate
    if params['tax_id'].present?
      @tax = TaxRate.find(params['tax_id'])
    end

    respond_to do |format|
      format.json { render json: @tax.to_json, status: 200 }
      format.html
    end
  end

  def find_term
    if params['term_id'].present?
      @payment_term = PaymentTerm.find(params['term_id'])
    end

    respond_to do |format|
      format.json { render json: @payment_term.to_json, status: 200 }
      format.html
    end
  end

  def item_collection
    @currency = Currency.find(params[:currency_id])
    @items = Item.where(currency: @currency).map { |column_label| { 'value': column_label.id, 'label': column_label.name } }

    respond_to do |format|
      format.json { render json: @items.to_json, status: 200 }
      format.html
    end
  end

  def find_currency
    @currency = Currency.find(params[:currency_id])
    @items = Item.where(currency: @currency) { |column_label| { 'value': column_label.id, 'label': column_label.name } }

    respond_to do |format|
      format.json { render json: { currency: @currency, items: @items }, status: 200 }
      format.html
    end
  end

  private

  def form_collection
    @customers = build_select_options(Customer.all, { label: %i[display_name], value: :id })
    @items = Item.all.map { |column_label| { 'value': column_label.id, 'label': column_label.name } }
    @tax_rates = build_select_options(TaxRate.all, { label: %i[select_label], value: :id })
    @terms = build_select_options(PaymentTerm.all, { label: %i[name], value: :id })
    @sales_persons = build_select_options(SalesPerson.all, { label: %i[name], value: :id })
    @custom_term = PaymentTerm.find_by_name('Custom').id
    @currencies = build_select_options(Currency.approved, { label: %i[code], value: :id })
  end

  def find_invoice
    @invoice = Invoice.find(params[:id])
  end

  def param_invoices
    params.require(:invoice).permit(:invoice_date, :po, :due_date, :account_number, :routing, :customer_id)
  end
end
