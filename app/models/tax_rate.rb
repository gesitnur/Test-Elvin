# frozen_string_literal: true

class TaxRate < ApplicationRecord
  has_many :items

  def select_label
    "#{name} [#{rate}%]"
  end

  validates :rate, numericality: { less_than_or_equal_to: 100 }
end

# == Schema Information
#
# Table name: tax_rates
#
#  id         :integer          not null, primary key
#  name       :string
#  rate       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
