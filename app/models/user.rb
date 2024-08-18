# frozen_string_literal: true

class User < ApplicationRecord
  include ApplicationHelper
  paginates_per 10
  acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company, optional: true
  belongs_to :position
  has_many :work_leave_requests
  accepts_nested_attributes_for :company
  has_many :survey_answers
  has_many :forum_replies
  has_many :forums
  has_many :bug_reports
  has_many :user_projects
  has_many :contracts

  validate :check_email_address
  validates :name, :email, presence: true

  scope :with_company, ->(company) { where(company: company) }
  scope :employee, -> { includes(:position).where.not(position: { name: ["Admin", "Owner"] }) }
  scope :project_employee, -> { includes(:position).where.not(position: { name: ["Admin", "Owner", "Cleaning Service"] }) }

  before_create :confirmation_token

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  def check_email_address
    return if email.blank?

    blocked_email = %w[google.com yahoo.com]
    return unless blocked_email.include? email.split('@').last

    errorsp.add(:base, 'Cannot use this email address')
  end

  def part_of_company?(subdomain)
    return true unless tenant_present?(subdomain)

    company.slug.eql?(Apartment::Tenant.current)
  end

  private

  def confirmation_token
    return unless confirm_token.blank?

    self.confirm_token = SecureRandom.hex(16)
  end

  def password_required?
    false
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  address                :text
#  confirm_token          :string
#  date_of_birth          :date
#  domicile               :string
#  email                  :string           default(""), not null
#  email_confirmed        :boolean
#  encrypted_password     :string           default(""), not null
#  gender                 :integer
#  graduated              :text
#  is_pic                 :boolean          default(FALSE)
#  leave_request_balance  :integer          default(0)
#  name                   :string
#  nik                    :string
#  npwp                   :string
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :integer
#  position_id            :integer
#
# Indexes
#
#  index_users_on_company_id            (company_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_position_id           (position_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
