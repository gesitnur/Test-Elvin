# frozen_string_literal: true

module Modules
  module CashReport
    extend ActiveSupport::Concern

    def calculate_general_tab(from_date, currencies, date_range)
      report_data = []
      months = (1..12).to_a

      currencies.each do |currency|
        income_chart = {}
        expense_chart = {}
        balance = currency.calculate_balance_cash_book(from_date)

        @income_daily_reports = Transaction.joins(:cash_book).where(cash_book: { currency_id: currency }).income
                                           .where(transaction_date: date_range)
        @expense_daily_reports = Transaction.joins(:cash_book).where(cash_book: { currency_id: currency }).expense
                                            .where(transaction_date: date_range)

        if action_name.eql?('annually')
          months.each do |month|
            date = Date.new(params[:year].to_i, month)
            income_chart[Date::ABBR_MONTHNAMES[month]] = @income_daily_reports.where(transaction_date:
                                                                                      date.beginning_of_month..
                                                                                      date.end_of_month).sum(&:amount)
            expense_chart[Date::ABBR_MONTHNAMES[month]] = @expense_daily_reports.where(transaction_date:
                                                                                        date.beginning_of_month..
                                                                                        date.end_of_month).sum(&:amount)
          end
        end

        report_data.push({ "#{currency.code}": { Income: @income_daily_reports.sum(&:amount), balance: balance,
                                                   Expense: @expense_daily_reports.sum(&:amount),
                                                   income_detail: @income_daily_reports.joins(:cash_book_category)
                                                                    .group('cash_book_categories.name').sum(:amount),
                                                   expense_detail: @expense_daily_reports.joins(:cash_book_category)
                                                                    .group('cash_book_categories.name').sum(:amount),
                                                   income_chart: income_chart,
                                                   expense_chart: expense_chart } })
      end

      report_data
    end

    def calculate_expense_tab(currencies, date_range)
      expense_data = {}

      currencies.each do |currency|
        @income_daily_reports = Transaction.joins(:cash_book).where(cash_book: { currency_id: currency }).income
                                           .where(transaction_date: date_range)
        @expense_daily_reports = Transaction.joins(:cash_book).where(cash_book: { currency_id: currency }).expense
                                            .where(transaction_date: date_range)

        expense_data[currency.code] = { Income_test: @income_daily_reports.joins(:cash_book_category)
                                                                            .group_by { |task| task.cash_book_category.name },
                                          Expense_test: @expense_daily_reports.joins(:cash_book_category)
                                                                              .group_by { |task| task.cash_book_category.name } }
      end

      expense_data
    end

    def calculate_transfer_tab(cash_books, date_range)
      transfer_data = {}

      cash_books.each do |cash_book|
        transfer_data[cash_book.name] = cash_book.transactions.transfer.where(transaction_date: date_range)
      end

      transfer_data
    end
  end
end
