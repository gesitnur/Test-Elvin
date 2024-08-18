# frozen_string_literal: true

class User::DashboardController < User::BaseController
  include Modules::CashReport

  def index
    @employee_total = User.count
    @cash_book_total = CashBook.count
    @debt_total = Debt.count
    @credit_total = Credit.count
    @invoices = Invoice.last(3)

    params[:date] = Date.today
    app_setting
    currency = current_user.company.app_setting.currency
    @income_reports = Transaction.all.sum(:amount)
    @expense_reports = Transaction.joins(:cash_book).where(cash_book: { currency_id: currency }).expense.joins(:cash_book_category)
                                  .group('cash_book_categories.name').sum(:amount)
  end

  def chart_dashboard
    @currencies = [currency]

    if params[:income_type].eql?('daily')
      params[:date] = Date.today
      @income_date_range  = params[:date].to_date.beginning_of_day..params[:date].to_date.end_of_day
      @income_date_header = params[:date].to_date.strftime('%d %B %Y')
      @income_type = 'daily'
    elsif params[:income_type].eql?('weekly')
      params[:date] = Date.today
      @income_date_range = params[:date].to_date.beginning_of_week..params[:date].to_date.end_of_week
      @income_date_header = "#{params[:date].to_date.beginning_of_week.strftime('%d %h %Y')} -
                      #{params[:date].to_date.end_of_week.strftime('%d %h %Y')}"
      @income_type = 'weekly'
    elsif params[:income_type].eql?('monthly')
      params[:month] ||= Date.today.month
      params[:year] ||= Date.today.year
      @income_date_range = Date.new(params[:year].to_i, params[:month].to_i).beginning_of_month..
                    Date.new(params[:year].to_i, params[:month].to_i).end_of_month
      @income_date_header = Date.new(params[:year].to_i, params[:month].to_i).strftime('%B %Y')
      @income_type = 'monthly'
    elsif params[:income_type].eql?('annually')
      params[:month] ||= Date.today.month
      params[:year] ||= Date.today.year
      @income_date_range = Date.new(params[:year].to_i).beginning_of_year..
                    Date.new(params[:year].to_i).end_of_year
      @income_date_header = params[:year]
      @income_type = 'annually'
    end

    if params[:expense_type].eql?('daily')
      params[:date] = Date.today
      @expense_date_range  = params[:date].to_date.beginning_of_day..params[:date].to_date.end_of_day
      @expense_date_header = params[:date].to_date.strftime('%d %B %Y')
      @expense_type = 'daily'
    elsif params[:expense_type].eql?('weekly')
      params[:date] = Date.today
      @expense_date_range = params[:date].to_date.beginning_of_week..params[:date].to_date.end_of_week
      @expense_date_header = "#{params[:date].to_date.beginning_of_week.strftime('%d %h %Y')} -
                      #{params[:date].to_date.end_of_week.strftime('%d %h %Y')}"
      @expense_type = 'weekly'
    elsif params[:expense_type].eql?('monthly')
      params[:month] ||= Date.today.month
      params[:year] ||= Date.today.year
      @expense_date_range = Date.new(params[:year].to_i, params[:month].to_i).beginning_of_month..
                    Date.new(params[:year].to_i, params[:month].to_i).end_of_month
      @expense_date_header = Date.new(params[:year].to_i, params[:month].to_i).strftime('%B %Y')
      @expense_type = 'monthly'
    elsif params[:expense_type].eql?('annually')
      params[:month] ||= Date.today.month
      params[:year] ||= Date.today.year
      @expense_date_range = Date.new(params[:year].to_i).beginning_of_year..
                    Date.new(params[:year].to_i).end_of_year
      @expense_date_header = params[:year]
      @expense_type = 'annually'
    end

    @income_reports = Transaction.joins(:cash_book).where(cash_book: { currency_id: currency }).income
                                 .where(transaction_date: @income_date_range).joins(:cash_book_category)
                                 .group('cash_book_categories.name').sum(:amount)
    @expense_reports = Transaction.joins(:cash_book).where(cash_book: { currency_id: currency }).expense
                                  .where(transaction_date: @expense_date_range).joins(:cash_book_category)
                                  .group('cash_book_categories.name').sum(:amount)
  end
end
