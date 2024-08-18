# frozen_string_literal: true

module ApplicationHelper
  def show_svg(path)
    return if path.blank?

    File.open("app/assets/images/#{path}", 'rb') do |file|
      raw file.read
    end
  end

  def asset_image(file)
    file
  end

  def company_logo_image(file)
    return 'elvin/no-image.png' if file.blank?

    file
  end

  def nineod_active_section(action_name, current_action, navbar_class = 'navbar-active')
    return navbar_class if action_name.eql?(current_action)
  end

  def coming_soon_content(coming_soon_title)
    split_content = coming_soon_title.titleize.split.map.with_index { |text, key| key.even? ? text : "<span class='title-second'>#{text}</span>" }

    split_content.join(' ').html_safe
  end

  def label_read(condition = nil)
    label_read = '<span href="" class="p-1 text-sm bg-powderBlue rounded">Read</span>'
    label_unread = '<span href="" class="p-1 text-sm bg-orange-300 rounded">Unread</span>'

    return label_read.html_safe if condition.eql?(true) || condition.try(:downcase).eql?('true')

    label_unread.html_safe
  end

  def no_table_record(objects = [], columns = 5, message = 'No Records found')
    return "<tr><td colspan='#{columns}' class='text-center border py-2'>#{message}</tr>".html_safe if objects.blank?
  end

  def load_flash_alert
    return '' if flash[:alert].blank?

    render partial: 'shared/global/components/alert', locals: { alert: flash[:alert] }
  end

  def load_flash_notice
    return '' if flash[:notice].blank? || flash[:alert].present?

    render partial: 'shared/global/components/notice', locals: { notice: flash[:notice] }
  end

  def class_active(section_name, current_section)
    return 'active' if section_name.eql?(current_section)
  end

  def date_formater(date_data = nil, date_format = '%d/%m/%Y')
    return '' if !date_data.respond_to?(:to_date) || date_data.blank?

    if date_format.include?('%A') || date_format.include?('%a')
      day         = I18n.l(date_data, format: '%A')
      date_format = date_format.gsub('%A', day).gsub('%a', day)
    end

    begin
      date_data.strftime(date_format)
    rescue StandardError
      ''
    end
  end

  def time_formater(date_data = nil, date_format = '%I:%M %p')
    return '' if !date_data.respond_to?(:to_date) || date_data.blank?

    begin
      date_data.strftime(date_format)
    rescue StandardError
      ''
    end
  end

  def datetime_formater(date_data = nil, date_format = nil)
    return '' if !date_data.respond_to?(:to_date) || date_data.blank?

    if date_format.present?
      begin
        date_data.strftime(date_format)
      rescue StandardError
        nil
      end
    else
      "#{date_formater(date_data)} #{time_formater(date_data)}"
    end
  end

  def label_yes_no(condition = nil)
    label_yes = 'Yes'
    label_no  = 'No'

    return label_yes if condition.eql?(true) || condition.try(:downcase).eql?('true')

    label_no
  end

  def label_trial_training(interview)
    label = if interview.is_training? && interview.is_trial?
              '<span class="bg-powderBlue py-1 inline-block w-[70px] text-center rounded-full font-bold text-pacifixBlue text-sm">Training</span> <span class="bg-orange-200 inline-block py-1 w-[70px] text-center text-orange-600 font-bold rounded-full text-sm">Trial</span>'
            elsif interview.is_training?
              '<span class="bg-powderBlue py-1 inline-block w-[70px] text-center rounded-full font-bold text-pacifixBlue text-sm">Training</span>'
            elsif interview.is_trial?
              '<span class="bg-orange-200 inline-block py-1 w-[70px] text-center text-orange-600 font-bold rounded-full text-sm">Trial</span>'
            else
              '<div class="bg-yellow-400 w-7 h-7 rounded text-white inline-block mb-1">
                <span class="flex h-full"><i class="fa fa-exclamation-triangle m-auto" aria-hidden="true"></i></span>
               </div>'
            end
    label.html_safe
  end

  def display_option(option = '', choosen = '', correct = '', is_basic = false)
    if option.eql?(choosen)
      if is_basic
        ' rounded border border-green-500'
      else
        ' rounded border border-red-500'
      end
    elsif option.eql?(correct) && !is_basic
      ' rounded border border-green-500'
    end
  end

  def active_gameplay_class(key)
    if key.eql?(1)
      ' active-section'
    else
      ' hidden'
    end
  end

  def checked_option(option, radio_value)
    return true if radio_value.eql?(option)
  end

  def disable_answer(interview_gameplay)
    return true if interview_gameplay.completed?
  end

  def display_score(interview_gameplay)
    return if interview_gameplay.scoring? || interview_gameplay.gameplay.basic_gameplay?

    "<span>Score : #{interview_gameplay.total_score.round(1)}</span>".html_safe
  end

  def checkmark(gameplay, option = '', answer = '')
    return unless option.eql? answer
    return if gameplay.basic_gameplay?

    '( <i class="fa fa-check" aria-hidden="true"></i> Correct Answer )'.html_safe
  end

  def tenant_present?(subdomain)
    Apartment.tenant_names.include?(subdomain)
  end

  def date_formater(date_data = nil, date_format = '%d/%m/%Y')
    '' if !date_data.respond_to?(:to_date) || date_data.blank?

    begin
      date_data.strftime(date_format)
    rescue StandardError
      nil
    end
  end

  def time_formater(date_data = nil, date_format = '%I:%M %p')
    '' if !date_data.respond_to?(:to_date) || date_data.blank?

    begin
      date_data.strftime(date_format)
    rescue StandardError
      nil
    end
  end

  def datetime_formater(date_data = nil, date_format = nil)
    '' if !date_data.respond_to?(:to_date) || date_data.blank?

    if date_format.present?
      begin
        date_data.strftime(date_format)
      rescue StandardError
        nil
      end
    else
      "#{date_formater(date_data)} #{time_formater(date_data)}"
    end
  end

  def build_select_options(objects, columns = { label: ['name'], value: 'id' })
    return [] if objects.blank?

    data = []
    objects.each do |object|
      # set select option label
      label = columns[:label].map { |column_label| object.send(column_label).to_s }
      label = label.reject(&:blank?).join(' - ')
      # set select option value
      value = object.send(columns[:value])

      data << [label, value]
    end

    data
  end

  def cash_book_select_options(objects, columns = { label: ['name'], value: 'id' })
    return [] if objects.blank?

    data = []
    objects.each do |object|
      label = "#{object.name} (#{object.currency.code})"
      value = object.send(columns[:value])

      data << [label, value]
    end

    data
  end

  def app_setting
    @currency = Currency.find_by_code('USD')
    if current_user.company.app_setting.blank?
      app_setting = current_user.company.build_app_setting
      app_setting.currency = @currency
      app_setting.save
    end

    current_user.company.app_setting
  end

  def transaction_class(type)
    if type.eql?('Income')
      'bg-green-100'
    elsif type.eql?('Expense')
      'bg-red-100'
    else
      'bg-blue-100'
    end
  end

  def debt_class(type, is_initial)
    if is_initial
      'bg-blue-100'
    elsif type.eql?('Expense')
      'bg-green-100'
    else
      'bg-red-100'
    end
  end

  def credit_class(type, is_initial)
    if is_initial
      'bg-blue-100'
    elsif type.eql?('Expense')
      'bg-red-100'
    else
      'bg-green-100'
    end
  end

  def debt_index_class(balance)
    if balance.zero?
      'bg-green-100'
    else
      'bg-red-100'
    end
  end

  def debt_icon_class(balance)
    if balance.zero?
      '<div class=""><i class="fa fa-circle text-green-800" title="Paid Off"></i></div>'.html_safe
    else
      '<div class=""><i class="fa fa-circle text-red-800" title="Not Yet Paid Off"></i></div>'.html_safe
    end
  end

  def transaction_icon(type)
    if type.eql?('Income')
      '<div class="font-bold rounded-full bg-white flex shadow items-center justify-center font-mono" title="Income"><i class="fas fa-level-down-alt my-2" aria-hidden="true"></i></div> '
    elsif type.eql?('Expense')
      '<div class="font-bold rounded-full bg-white flex shadow items-center justify-center font-mono" title="Expense"><i class="fas fa-level-up-alt my-2" aria-hidden="true"></i></div>'
    else
      '<div class="font-bold rounded-full bg-white flex shadow items-center justify-center font-mono" title="Transfer"><i class="fa fa-exchange-alt my-2" aria-hidden="true"></i></div>'
    end
  end

  def debt_item_icon(type)
    if type.eql?('Income')
      '<div class="font-bold rounded-full bg-white shadow flex items-center justify-center font-mono" title="Income"><i class="fas fa-plus my-2" aria-hidden="true"></i></div> '
    else
      '<div class="font-bold rounded-full bg-white shadow flex items-center justify-center font-mono" title="Transfer"><i class="fa fa-minus my-2" aria-hidden="true"></i></div>'
    end
  end

  def next_month_transaction(month, year, cash_book_id)
    Date.new(year, month).next_month
    user_transactions_path(cash_book_id: cash_book_id, month: Date.new(year, month).next_month.month, year: Date.new(year, month).next_month.year)
  end

  def prev_month_transaction(month, year, cash_book_id)
    Date.new(year, month).prev_month
    user_transactions_path(cash_book_id: cash_book_id, month: Date.new(year, month).prev_month.month, year: Date.new(year, month).prev_month.year)
  end

  def next_month_report(month, year, currency_id)
    Date.new(year, month).next_month
    monthly_user_cash_reports_path(currency_id: currency_id, month: Date.new(year, month).next_month.month, year: Date.new(year, month).next_month.year)
  end

  def prev_month_report(month, year, currency_id)
    Date.new(year, month).prev_month
    monthly_user_cash_reports_path(currency_id: currency_id, month: Date.new(year, month).prev_month.month, year: Date.new(year, month).prev_month.year)
  end

  def next_month_expense_report(month, year, currency_id)
    Date.new(year, month).next_month
    monthly_expense_user_cash_reports_path(currency_id: currency_id, month: Date.new(year, month).next_month.month, year: Date.new(year, month).next_month.year)
  end

  def prev_month_expense_report(month, year, currency_id)
    Date.new(year, month).prev_month
    monthly_expense_user_cash_reports_path(currency_id: currency_id, month: Date.new(year, month).prev_month.month, year: Date.new(year, month).prev_month.year)
  end

  def next_month_transfer_report(month, year, currency_id)
    Date.new(year, month).next_month
    monthly_transfer_user_cash_reports_path(currency_id: currency_id, month: Date.new(year, month).next_month.month, year: Date.new(year, month).next_month.year)
  end

  def prev_month_transfer_report(month, year, currency_id)
    Date.new(year, month).prev_month
    monthly_transfer_user_cash_reports_path(currency_id: currency_id, month: Date.new(year, month).prev_month.month, year: Date.new(year, month).prev_month.year)
  end

  def next_year_report(year, currency_id)
    annually_user_cash_reports_path(currency_id: currency_id, year: Date.new(year).next_year)
  end

  def prev_year_report(year, currency_id)
    annually_user_cash_reports_path(currency_id: currency_id, year: Date.new(year).prev_year)
  end

  def next_year_transfer_report(year, currency_id)
    annually_transfer_user_cash_reports_path(currency_id: currency_id, year: Date.new(year).next_year)
  end

  def prev_year_transfer_report(year, currency_id)
    annually_transfer_user_cash_reports_path(currency_id: currency_id, year: Date.new(year).prev_year)
  end

  def next_year_expense_report(year, currency_id)
    annually_expense_user_cash_reports_path(currency_id: currency_id, year: Date.new(year).next_year)
  end

  def prev_year_expense_report(year, currency_id)
    annually_expense_user_cash_reports_path(currency_id: currency_id, year: Date.new(year).prev_year)
  end

  def active_section?(section_name, current_section, is_default = false, section_class = 'active')
    section_class ||= 'active'
    return section_class if section_name.eql?(current_section) || is_default
  end

  def part_of_invoice_section?(controller_name)
    return if %w[invoices items customers tax_rates sales_persons payment_terms currencies payments].include?(controller_name)

    'hidden'
  end

  def part_of_report_section?(action_name)
    return if %w[daily daily_expense daily_transfer weekly weekly_expense weekly_transfer monthly monthly_expense monthly_transfer annually annually_expense annually_transfer].include?(action_name)

    'hidden'
  end

  def part_of_debt_section?(controller_name)
    return if %w[debts debt_items credits credit_items].include?(controller_name)

    'hidden'
  end

  def part_of_help_center_section?(controller_name)
    return if %w[help_centers help_center_categories].include?(controller_name)

    'hidden'
  end

  def invoice_active?(controller_name)
    return unless %w[invoices items customers tax_rates sales_persons payment_terms currencies payments].include?(controller_name)

    'active'
  end

  def debt_active?(controller_name)
    return unless %w[debts debt_items credits credit_items].include?(controller_name)

    'active'
  end

  def help_center_active?(controller_name)
    return unless %w[help_centers help_center_categories].include?(controller_name)

    'active'
  end

  def report_active?(action_name)
    return unless %w[daily daily_expense daily_transfer weekly weekly_expense weekly_transfer monthly monthly_expense monthly_transfer annually annually_expense annually_transfer].include?(action_name)

    'active'
  end

  def part_of_cash_section?(controller_name)
    return if %w[cash_books transactions cash_book_categories recurrings].include?(controller_name)

    'hidden'
  end

  def cash_book_active?(controller_name)
    return unless %w[cash_books transactions cash_book_categories recurrings].include?(controller_name)

    'active'
  end

  def part_of_setting_section?(controller_name)
    return if %w[website_settings app_settings leave_types company_holidays].include?(controller_name)

    'hidden'
  end

  def setting_active?(controller_name)
    return unless %w[website_settings app_settings leave_types company_holidays].include?(controller_name)

    'active'
  end

  def transaction_label(transaction)
    if transaction.transaction_type.eql?('Transfer')
      "Transfer from #{CashBook.find(transaction.transfer_from).name} To #{CashBook.find(transaction.transfer_to).name}"
    elsif transaction.cash_book_category_id.blank? && transaction.cash_book_category.blank?
      'Start Balance'
    else
      transaction.cash_book_category&.name
    end
  end

  def customer_notes_value(invoice)
    if invoice.new_record?
      app_setting.customer_note
    else
      invoice.customer_notes
    end
  end

  def term_condition_value(invoice)
    if invoice.new_record?
      app_setting.term_and_condition
    else
      invoice.term_and_condition
    end
  end

  def invoice_filter_class(filter)
    return unless filter

    'is-filtered'
  end

  def daily_report_url
    url = if action_name.eql?('daily')
            daily_user_cash_reports_path(date: params[:date], currency_id: params[:currency_id], title: 'Daily Report', format: 'pdf')
          elsif action_name.eql?('daily_expense')
            daily_expense_user_cash_reports_path(date: params[:date], currency_id: params[:currency_id], title: 'Daily Report', format: 'pdf')
          else
            daily_transfer_user_cash_reports_path(date: params[:date], currency_id: params[:currency_id], title: 'Daily Report', format: 'pdf')
          end
    url
  end

  def weekly_report_url
    url = if action_name.eql?('weekly')
            weekly_user_cash_reports_path(date: params[:date], currency_id: params[:currency_id], title: 'Weekly Report', format: 'pdf')
          elsif action_name.eql?('weekly_expense')
            weekly_expense_user_cash_reports_path(date: params[:date], currency_id: params[:currency_id], title: 'Weekly Report', format: 'pdf')
          else
            weekly_transfer_user_cash_reports_path(date: params[:date], currency_id: params[:currency_id], title: 'Weekly Report', format: 'pdf')
          end
    url
  end

  def monthly_report_url
    url = if action_name.eql?('monthly')
            monthly_user_cash_reports_path(date: params[:date], currency_id: params[:currency_id], title: 'Monthly Report', format: 'pdf')
          elsif action_name.eql?('monthly_expense')
            monthly_expense_user_cash_reports_path(date: params[:date], currency_id: params[:currency_id], title: 'Monthly Report', format: 'pdf')
          else
            monthly_transfer_user_cash_reports_path(date: params[:date], currency_id: params[:currency_id], title: 'Monthly Report', format: 'pdf')
          end
    url
  end

  def annually_report_url
    url = if action_name.eql?('annually')
            annually_user_cash_reports_path(date: params[:date], currency_id: params[:currency_id], title: 'Annually Report', format: 'pdf')
          elsif action_name.eql?('annually_expense')
            annually_expense_user_cash_reports_path(date: params[:date], currency_id: params[:currency_id], title: 'Annually Report', format: 'pdf')
          else
            annually_transfer_user_cash_reports_path(date: params[:date], currency_id: params[:currency_id], title: 'Annually Report', format: 'pdf')
          end
    url
  end

  def recurring_amount(recurring)
    if recurring.Expense?
      number_to_currency(recurring.amount, unit: recurring.cash_book.currency.symbol)
    else
      recurring.transfer_from_amount
      CashBook.find(recurring.transfer_from).inspect
      number_to_currency(recurring.transfer_from_amount, unit: CashBook.find(recurring.transfer_from).currency.symbol)
    end
  end

  def position_access(access)
    if access
      '<i class="far fa-check-circle text-pacifixBlue"></i>'.html_safe
    else
      '<i class="far fa-times-circle text-red-500"></i>'.html_safe
    end
  end

  def calculate_day_off(leave_request)
    if leave_request.end_date.present?
      leave_request.number_of_day
    elsif leave_request.not_filled?
      '-'
    else
      '1'
    end
  end

  def leave_request_date_range(leave_request)
    if leave_request.end_date.blank?
      date_formater(leave_request.start_date, '%a %d %b, %Y')
    else
      "#{date_formater(leave_request.start_date, '%a %d %b, %Y')} - #{date_formater(leave_request.end_date, '%a %d %b, %Y')}"
    end
  end

  def employee_website_setting(employee)
    if employee.company.website_setting.blank?
      WebsiteSetting.find_by_company_id(nil)
    else
      @website_setting = employee.company.website_setting
    end
  end

  def ransack_params
    param = (params[:q] || {})
    return {} if param.blank?

    param.delete_if { |_key, value| value.blank? }
  end

  def holiday_date_range(holiday)
    if holiday.start_date.eql?(holiday.end_date)
      date_formater(holiday.start_date, '%d %h %Y')
    else
      "#{date_formater(holiday.start_date, '%d %h %Y')} - #{date_formater(holiday.end_date, '%d %h %Y')}"
    end
  end

  def get_presence_data(date, user)
    Attendance.where(date: date.beginning_of_day..date.end_of_day, user_id: user.id).first&.checkin_time&.strftime('%d %B %Y %H:%M')
  end

  def get_checkout_data(date, user)
    Attendance.where(date: date.beginning_of_day..date.end_of_day, user_id: user.id).first&.checkout_time&.strftime('%d %B %Y %H:%M')
  end

  def get_overtime_in_data(date, user)
    Attendance.where(date: date.beginning_of_day..date.end_of_day, user_id: user.id).first&.overtime_start&.strftime('%d %B %Y %H:%M')
  end

  def get_overtime_in(date, user)
    Attendance.where(date: date.beginning_of_day..date.end_of_day, user_id: user.id).first&.overtime_start
  end

  def get_overtime_out_data(date, user)
    Attendance.where(date: date.beginning_of_day..date.end_of_day, user_id: user.id).first&.overtime_end&.strftime('%d %B %Y %H:%M')
  end
end
