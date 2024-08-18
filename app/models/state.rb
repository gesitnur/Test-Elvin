# frozen_string_literal: true

class State < ApplicationRecord
  belongs_to :country

  has_many :billing_addresses
  has_many :shipping_addresses
  has_many :app_settings

  validates :name, :code, presence: true
end

# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :integer
#
# Indexes
#
#  index_states_on_country_id  (country_id)
#
