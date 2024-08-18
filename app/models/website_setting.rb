# frozen_string_literal: true

class WebsiteSetting < ApplicationRecord
  belongs_to :company, optional: true

  validates :company, uniqueness: true

  def self.generate_default_data
    WebsiteSetting.destroy_all
    new_website_setting = WebsiteSetting.new({
                                               coming_soon_title: 'Coming Soon',
                                               coming_soon_description: 'We are currently working on a new super cool website without newsletter, and standar comming soon font & color',
                                               pending_leave_request_message: 'Waiting for your owner approval',
                                               accepted_leave_request_message: 'Your request has been approval',
                                               rejected_leave_request_message: 'Your request has been refused'
                                             })

    if new_website_setting.save
      puts 'Website Setting successfully created'
    else
      puts "Website Setting => errors: #{new_website_setting.errors.full_messages.join(', ')}"
    end
  end
end

# == Schema Information
#
# Table name: website_settings
#
#  id                             :integer          not null, primary key
#  accepted_leave_request_message :text
#  coming_soon_description        :text
#  coming_soon_title              :string
#  pending_leave_request_message  :text
#  rejected_leave_request_message :text
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  company_id                     :integer
#
# Indexes
#
#  index_website_settings_on_company_id  (company_id)
#
