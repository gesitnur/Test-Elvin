# frozen_string_literal: true

class Attachment < ApplicationRecord
  include AttachmentUploader::Attachment(:attachment)

  belongs_to :invoice
end

# == Schema Information
#
# Table name: attachments
#
#  id              :integer          not null, primary key
#  attachment_data :text
#  attachment_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  invoice_id      :integer
#
# Indexes
#
#  index_attachments_on_invoice_id  (invoice_id)
#
