# frozen_string_literal: true

class WorkLeaveRequest < ApplicationRecord
  paginates_per 10
  include AASM

  belongs_to :user
  belongs_to :leave_type, optional: true

  aasm(column: 'status') do
    state :not_filled, initial: true
    state :pending, :approved, :rejected

    event :not_filled do
      transitions from: %i[rejected pending], to: :not_filled
    end

    event :pending do
      transitions from: %i[not_filled], to: :pending
    end

    event :approve do
      transitions from: %i[pending], to: :approved
    end

    event :reject do
      transitions from: %i[pending], to: :rejected
    end
  end

  after_create :generate_encrypted_code

  scope :history_data, -> { where.not(status: 'not_filled').where.not(status: 'pending') }
  scope :balance_data, -> { where.not(status: 'not_filled').where.not(status: 'rejected') }

  scope :pending_data, -> { where.not(status: 'approved').where.not(status: 'not_filled') }
  scope :day_off_data, -> { where(status: 'approved') }

  scope :sorted_by_priority_and_start_date, -> { order(priority: :desc, start_date: :asc) }

  # validate :check_not_filled_request
  validate :cannot_select_forbidden_dates

  def generate_encrypted_code
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31])
    encrypted_data = crypt.encrypt_and_sign("#{user.id}+#{id}")
    self.encrypted_code = encrypted_data
    save
  end

  def check_start_date(start_date_param)
    date_range = start_date_param.tr(' ', '').split('-')
    self.start_date = Date.strptime(date_range.first, '%m/%d/%Y')

    self.end_date = if date_range.second.present?
                      Date.strptime(date_range.second, '%m/%d/%Y')
                    else
                      self.end_date = nil
                    end

    save
  end

  def check_not_filled_request
    return if user.work_leave_requests.not_filled.blank?
    return unless new_record?

    errors.add :base, 'cannot generate link'
  end

  def cannot_select_forbidden_dates
    return unless self.new_record?

    forbidden_dates = []
    user.work_leave_requests.each do |leave_request|
      end_date = leave_request.end_date || leave_request.start_date
      dates = (leave_request.start_date..end_date).to_a
      dates.each do |date|
        forbidden_dates << date
      end
    end


    if start_date.present? && start_date.in?(forbidden_dates)
      errors.add(:base, "Anda sudah mengajukan cuti di tanggal ini, silahkan pilih tanggal lain")
    elsif end_date.present? && end_date.in?(forbidden_dates)
      errors.add(:base, "Anda sudah mengajukan cuti di tanggal ini, silahkan pilih tanggal lain")
    elsif start_date.present? && end_date.present? &&
       (start_date..end_date).to_a.any? { |date| forbidden_dates.include?(date) }
      errors.add(:base, "Anda sudah mengajukan cuti di tanggal ini, silahkan pilih tanggal lain")
    end
    # debugger
    # # user.user_projects
    date_ranges = if end_date.present?
      (start_date..end_date).to_a
    else
      [start_date]
    end
    date_ranges.each do |date|
      debugger
      user.user_projects.each do |user_project|
        member_ids = user_project.project.user_projects.map(&:user_id)
        total_member = member_ids.count
        member_leave_request_date = []

        # leave = WorkLeaveRequest.where date().where_user_id = member_ids
        leave_requests = WorkLeaveRequest.approved.where(user_id: member_ids)
        debugger
        leave_requests.each do |leave_request|
          # member_leave_request_date.push(leave_request.date_range)
          leave_request.date_range.each do |leave_request_date|
            member_leave_request_date.push(leave_request_date)
          end
        end

        total_leave_request_in_date = member_leave_request_date.select { |i| i == date }.count
        # debugger


        if total_leave_request_in_date == (total_member - 1)
          errors.add(:base, "silahkan pilih pengajuan cuti di tanggal lain")
        end
      end

    end

  end

  def date_range
    if end_date
      (start_date..end_date).to_a
    else
      [start_date]
    end
  end

  # enum leave_type: { 'Leave': 0, 'Sick': 1 }
  enum leave_period: { 'fullday': 0, 'halfday': 1 }
end

# == Schema Information
#
# Table name: work_leave_requests
#
#  id                  :integer          not null, primary key
#  approval_date       :datetime
#  approved_by         :integer
#  encrypted_code      :text
#  end_date            :date
#  is_editable         :boolean          default(TRUE)
#  leave_period        :integer
#  number_of_day       :integer
#  reason              :text
#  reject_reason       :text
#  start_date          :date
#  status              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  leave_type_id       :integer
#  replacement_user_id :integer
#  user_id             :integer
#
# Indexes
#
#  index_work_leave_requests_on_leave_type_id  (leave_type_id)
#  index_work_leave_requests_on_user_id        (user_id)
#
