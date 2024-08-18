# frozen_string_literal: true

class User::CashReportsController < User::BaseController
  include Modules::CashReport
  before_action :currency_list
  before_action :currency__collection, only: %i[daily daily_expense weekly weekly_expense
                                                monthly monthly_expense annually annually_expense]
  before_action :years_data, only: %i[monthly monthly_expense monthly_transfer annually
                                      annually_expense annually_transfer]
  before_action :cash_book_data, only: %i[daily_transfer weekly_transfer monthly_transfer annually_transfer]
  before_action :init_params_date, only: %i[daily daily_expense daily_transfer weekly
                                            weekly_expense weekly_transfer]

  def daily
    @report_data = calculate_general_tab(params[:date].to_date.beginning_of_day, @currencies,
                                         params[:date].to_date.beginning_of_day..
                                         params[:date].to_date.end_of_day)
    @date_header = params[:date].to_date.strftime('%d %B %Y')
    @balance_label = 'day'
    respond_export_pdf
  end

  def daily_expense
    @expense_data = calculate_expense_tab(@currencies, params[:date].to_date.beginning_of_day..
                                          params[:date].to_date.end_of_day)
    @date_header = params[:date].to_date.strftime('%d %B %Y')
    @balance_label = 'day'
    respond_export_expense_pdf
  end

  def daily_transfer
    @transfers = calculate_transfer_tab(@cash_books, params[:date].to_date.beginning_of_day..
                                        params[:date].to_date.end_of_day)
    @date_header = params[:date].to_date.strftime('%d %B %Y')
    @balance_label = 'day'
    respond_export_transfer_pdf
  end

  def weekly
    @report_data = calculate_general_tab(params[:date].to_date.beginning_of_week, @currencies,
                                         params[:date].to_date.beginning_of_week..
                                         params[:date].to_date.end_of_week)
    @date_header = "#{params[:date].to_date.beginning_of_week.strftime('%d %h %Y')} -
    #{params[:date].to_date.end_of_week.strftime('%d %h %Y')}"
    @balance_label = 'week'
    respond_export_pdf
  end

  def weekly_expense
    @expense_data = calculate_expense_tab(@currencies, params[:date].to_date.beginning_of_week..
                                          params[:date].to_date.end_of_week)
    @date_header = "#{params[:date].to_date.beginning_of_week.strftime('%d %h %Y')} -
    #{params[:date].to_date.end_of_week.strftime('%d %h %Y')}"
    @balance_label = 'week'
    respond_export_expense_pdf
  end

  def weekly_transfer
    @transfers = calculate_transfer_tab(@cash_books,
                                        params[:date].to_date.beginning_of_week..params[:date].to_date.end_of_week)
    @date_header = "#{params[:date].to_date.beginning_of_week.strftime('%d %h %Y')} -
    #{params[:date].to_date.end_of_week.strftime('%d %h %Y')}"
    @balance_label = 'week'
    respond_export_transfer_pdf
  end

  def monthly
    @report_data = calculate_general_tab(Date.new(params[:year].to_i, params[:month].to_i).beginning_of_month, @currencies,
                                         Date.new(params[:year].to_i, params[:month].to_i).beginning_of_month..
                                         Date.new(params[:year].to_i, params[:month].to_i).end_of_month)
    @date_header = Date.new(params[:year].to_i, params[:month].to_i).strftime('%B %Y')
    @balance_label = 'month'
    respond_export_pdf
  end

  def monthly_expense
    @expense_data = calculate_expense_tab(@currencies,
                                          Date.new(params[:year].to_i, params[:month].to_i).beginning_of_month..
                                          Date.new(params[:year].to_i, params[:month].to_i).end_of_month)
    @date_header = Date.new(params[:year].to_i, params[:month].to_i).strftime('%B %Y')
    @balance_label = 'month'
    respond_export_expense_pdf
  end

  def monthly_transfer
    @transfers = calculate_transfer_tab(@cash_books,
                                        Date.new(params[:year].to_i, params[:month].to_i).beginning_of_month..
                                        Date.new(params[:year].to_i, params[:month].to_i).end_of_month)
    @date_header = Date.new(params[:year].to_i, params[:month].to_i).strftime('%B %Y')
    @balance_label = 'month'
    respond_export_transfer_pdf
  end

  def annually
    @report_data = calculate_general_tab(Date.new(params[:year].to_i).beginning_of_year, @currencies,
                                         Date.new(params[:year].to_i).beginning_of_year..
                                         Date.new(params[:year].to_i).end_of_year)
    @date_header = params[:year]
    @balance_label = 'year'
    respond_export_pdf
  end

  def annually_expense
    @expense_data = calculate_expense_tab(@currencies, Date.new(params[:year].to_i).beginning_of_year..
                                    Date.new(params[:year].to_i).end_of_year)
    @date_header = params[:year]
    @balance_label = 'year'
    respond_export_expense_pdf
  end

  def annually_transfer
    @transfers = calculate_transfer_tab(@cash_books, Date.new(params[:year].to_i).beginning_of_year..
                                        Date.new(params[:year].to_i).end_of_year)
    @date_header = params[:year]
    @balance_label = 'year'
    respond_export_transfer_pdf
  end

  private

  def years_data
    params[:month] ||= Date.today.month
    params[:year] ||= Date.today.year
    year_to = if Date.today.year >= params[:year].to_i
                Date.today.year
              else
                Date.new(params[:year].to_i).year
              end

    @months = Date::MONTHNAMES.drop(1).each_with_index.collect { |m, i| [m, i + 1] }
    @years = (Date.new(params[:year].to_i).years_ago(4).year..year_to).to_a
  end

  def currency_list
    @currency_list = CashBook.all.map(&:currency).uniq
  end

  def currency__collection
    @currencies = CashBook.all.map(&:currency).uniq
    @currencies = [Currency.find(params[:currency_id])] if params[:currency_id].present?
  end

  def cash_book_data
    @cash_books = CashBook.all
    @cash_books = CashBook.where(currency: params[:currency_id]) if params[:currency_id].present?
  end

  def init_params_date
    params[:date] = Date.today if params[:date].blank?
  end

  def respond_export_pdf
    respond_to do |format|
      format.html
      format.pdf do
        invoice = render_to_string 'export_pdf', formats: [:html], layout: 'cash_export_layout'
        pdf = Grover.new(invoice, format: 'A4', margin: { top: '40px', bottom: '40px' },
                                  display_url: request.base_url).to_pdf
        send_data pdf, filename: 'Cash Report General', type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def respond_export_expense_pdf
    respond_to do |format|
      format.html
      format.pdf do
        invoice = render_to_string 'export_activity_pdf', formats: [:html], layout: 'cash_export_layout'
        pdf = Grover.new(invoice, format: 'A4', margin: { top: '40px', bottom: '40px' },
                                  display_url: request.base_url).to_pdf
        send_data pdf, filename: 'Cash Report Activity', type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def respond_export_transfer_pdf
    respond_to do |format|
      format.html
      format.pdf do
        invoice = render_to_string 'export_transfer_pdf', formats: [:html], layout: 'cash_export_layout'
        pdf = Grover.new(invoice, format: 'A4', margin: { top: '40px', bottom: '40px' },
                                  display_url: request.base_url).to_pdf
        send_data pdf, filename: 'Cash Report Transfer', type: 'application/pdf', disposition: 'inline'
      end
    end
  end
end
