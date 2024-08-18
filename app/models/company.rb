# frozen_string_literal: true

class Company < ApplicationRecord
  validates :name, blacklist: true
  validate :verify_unique_company

  before_validation :set_slug
  after_create :create_tenant
  # after_create :create_app_setting

  has_many :users
  has_many :positions
  has_many :customers
  has_many :items
  has_many :cash_books
  has_many :bug_reports
  has_many :company_holidays

  has_one :website_setting
  has_one :app_setting

  validates :name, :address, :employee_range, presence: true

  enum employee_range: { 'Less than 5 employee': 1,
                         '5 - 10 Employee': 2,
                         'More than 5 employee': 3 }

  def verify_unique_company
    return unless Company.exists? slug: slug

    errors.add :name, message: 'has already been taken'
  end

  def set_slug
    return if name.blank?

    self.slug = name.parameterize
  end

  def self.full_hosts_hash
    Company.all.each_with_object({}) do |hash, company|
      hash[company.slug] = company.slug
      hash
    end
  end

  private

  def create_tenant
    Apartment::Tenant.create(slug)
  rescue Apartment::TenantExists
    true
  end

  def create_app_setting
    build_app_setting.save
  end
end

# == Schema Information
#
# Table name: companies
#
#  id             :integer          not null, primary key
#  address        :text
#  employee_range :integer
#  name           :string
#  slug           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
