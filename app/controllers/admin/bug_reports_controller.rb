# frozen_string_literal: true

class Admin::BugReportsController < Admin::BaseCrudController

  def index
    @statuses = BugReport.statuses
    @companies = build_select_options(Company.all, { label: %i[name], value: :id })
  end

  def set_to_fixed
    @bug_report = BugReport.find(params[:id])
    @bug_report.status = :fixed

    if @bug_report.save
      flash[:notice] = 'Bug report has been successfully fixed'
    else
      flash[:alert] = @bug_report.errors.full_messages
    end

    redirect_to admin_bug_reports_path
  end
end
