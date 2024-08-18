# frozen_string_literal: true

class Position < ApplicationRecord
  extend Modules::CrudAccess
  paginates_per 10

  CRUD_DATA = crud_data
  POSITION_DATA = position_data
  HRD_ACCESS = hrd_access
  EMP_ACCESS = emp_access

  belongs_to :company, optional: true
  has_many :users

  serialize :position_access, Hash

  enum position_type: { 'Super Admin': 1, 'App Organizer': 2, 'Employee': 3 }

  validates :name, :position_access, presence: true
  validates :name, uniqueness: true

  scope :with_company, ->(company) { where(company: nil).or(where(company: company)) }
  scope :without_owner, -> { where.not(name: 'Owner') }
  scope :employee, -> { where.not(name: ['Owner', 'Admin']) }

  def self.hrd_level
    data = {}
    data[:hrd] = {}
    HRD_ACCESS.each do |access|
      data[:hrd][access] = 0
    end
    data[:hrd]
  end

  def self.emp_level
    data = {}
    data[:emp] = {}
    EMP_ACCESS.each do |access|
      data[:emp][access] = 0
    end
    data[:emp]
  end

  POSITION_DATA.each do |position|
    define_method position do |access|
      return true if position_access[:owner].eql?(true)
      return if position_access.blank?

      position_split = position.split('_', 2)
      access_code = position_access[position_split.first.to_sym][position_split.second.to_sym]
      return if CRUD_DATA[access_code].blank?

      CRUD_DATA[access_code].include?(access)
    end
  end
end

# == Schema Information
#
# Table name: positions
#
#  id              :integer          not null, primary key
#  name            :string
#  position_access :text
#  position_type   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_id      :integer
#
# Indexes
#
#  index_positions_on_company_id  (company_id)
#
