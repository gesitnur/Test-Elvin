# frozen_string_literal: true

class SalesPerson < ApplicationRecord
  self.table_name = "sales_persons"
end

# == Schema Information
#
# Table name: sales_persons
#
#  id         :integer          not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#
# Indexes
#
#  index_sales_persons_on_company_id  (company_id)
#
