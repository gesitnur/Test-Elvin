# frozen_string_literal: true

class Attendance < ApplicationRecord

end

# == Schema Information
#
# Table name: attendances
#
#  id             :integer          not null, primary key
#  checkin_time   :datetime
#  checkout_time  :datetime
#  date           :datetime         not null
#  overtime_end   :datetime
#  overtime_start :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer          not null
#
# Indexes
#
#  index_attendances_on_user_id  (user_id)
#
