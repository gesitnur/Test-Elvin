# frozen_string_literal: true

module Modules
  module CrudAccess
    extend ActiveSupport::Concern

    def crud_data
      { 0 => [],
        1 => %i[create read update delete],
        2 => %i[read update delete],
        3 => %i[create read delete],
        4 => %i[create update delete],
        5 => %i[create read update],
        6 => %i[update delete],
        7 => %i[read delete],
        8 => %i[read update],
        9 => %i[create delete],
        10 => %i[create update],
        11 => %i[create read],
        12 => %i[create],
        13 => %i[read],
        14 => %i[update],
        15 => %i[delete] }
    end

    def position_data
      %w[hrd_invoice hrd_absence hrd_worker hrd_work_relation hrd_company_setting emp_absence emp_gaiya]
    end

    def hrd_access
      %i[invoice absence worker work_relation company_setting]
    end

    def emp_access
      %i[absence gaiya]
    end
  end
end
