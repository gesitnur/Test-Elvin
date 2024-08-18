# frozen_string_literal: true

class User::BugReportsController < User::BaseCrudController
  def index
    @bug_reports = @bug_reports.where(company: current_user.company)
  end
end
