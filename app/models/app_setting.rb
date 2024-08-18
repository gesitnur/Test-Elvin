# frozen_string_literal: true

class AppSetting < ApplicationRecord
  include ImageUploader::Attachment(:company_logo)

  belongs_to :company, optional: true
  belongs_to :country, optional: true
  belongs_to :language, class_name: 'Country', foreign_key: 'language_id', optional: true
  belongs_to :state, optional: true
  belongs_to :currency

  serialize :working_day, Hash

  enum industry: { 'Agency': 1, 'Education': 2, 'Government': 3 }
  enum fiscal_year: { 'January - December': 1, 'February - January': 2, 'March - February': 3 }

  validates :company, uniqueness: true
end

# == Schema Information
#
# Table name: app_settings
#
#  id                 :integer          not null, primary key
#  city               :string
#  company_email      :string
#  company_logo_data  :string
#  company_name       :string
#  customer_note      :text
#  fax                :string
#  fiscal_year        :integer
#  industry           :integer
#  phone              :string
#  report_basis       :string
#  start_date         :integer
#  street1            :string
#  street2            :string
#  term_and_condition :text
#  website            :string
#  working_day        :text
#  zip_code           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  company_id         :integer
#  country_id         :integer
#  currency_id        :integer
#  language_id        :integer
#  state_id           :integer
#
# Indexes
#
#  index_app_settings_on_company_id   (company_id)
#  index_app_settings_on_country_id   (country_id)
#  index_app_settings_on_currency_id  (currency_id)
#  index_app_settings_on_state_id     (state_id)
#
