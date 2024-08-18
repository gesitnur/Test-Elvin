# frozen_string_literal: true

class ContactRequest < ApplicationRecord
  paginates_per 10

  enum domain_request: { 'nineod.com': 1, 'nineodfreight.com': 2, 'elvin.co.id': 3 }

  scope :order_asc, -> { order(read: :asc) }

  def read_message
    self.read = true
    save
  end
end

# == Schema Information
#
# Table name: contact_requests
#
#  id             :integer          not null, primary key
#  domain_request :integer
#  email          :string
#  message        :text
#  name           :string
#  read           :boolean          default(FALSE)
#  subject        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
