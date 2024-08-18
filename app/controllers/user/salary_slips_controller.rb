# frozen_string_literal: true

class User::SalarySlipsController < ApplicationController
  layout 'owner_layout'

  def index
    # @transactions = @transactions.recurring
    @user = current_user
    @contract = @user.contracts.first
    @invoice = Invoice.last
    @period_this_month = Date.today.change(day: current_user.contracts.first.periode_slip_gaji)
    if @period_this_month > Date.today
      @period_this_month = @period_this_month - 1.month
    end

    @over_time_hour = 0

    @basic_salary = @contract.gaji_pokok.to_i / 126


    @start_month = @period_this_month - 1.month

    @weekday_count = (@start_month..@period_this_month).count { |date| (1..5).include?(date.wday) }

    @attendances = Attendance.where(date: @start_month..@period_this_month)

    @attendances.each do |attendance|
      over_time = (attendance.overtime_end - attendance.overtime_start) / 3600

      @over_time_hour += over_time.to_i
    end

    @over_time_salary = @over_time_hour * @basic_salary

    # 28 last month - 27 this month

    # @period_salary
  end
end
