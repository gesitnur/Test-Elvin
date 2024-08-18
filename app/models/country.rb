# frozen_string_literal: true

class Country < ApplicationRecord
  LANGUAGES = %w[Malay Chinese English Vietnamese Indonesian Tamil].freeze
  LANGUAGES_CODES = { English: :en, Malay: :ms, Chinese: :zh_cn, Vietnamese: :vi, Indonesian: :id, Tamil: :ta }.freeze

  has_many :states
  has_many :billing_addresses
  has_many :shipping_addresses
  has_many :app_settings
  has_one :currency

  validates :name, :code, presence: true

  def currency
    ISO3166::Country[code.downcase]&.currency_code
  end

  class << self
    def currencies
      currencies_data = []

      all.each do |country|
        currencies_data << country.currency if country.currency.present?
      end

      currencies_data
    end
  end
end

# == Schema Information
#
# Table name: countries
#
#  id            :integer          not null, primary key
#  code          :string
#  currency_code :string
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
