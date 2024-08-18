# frozen_string_literal: true

class Contract < ApplicationRecord
  belongs_to :user
end

# == Schema Information
#
# Table name: contracts
#
#  id                   :integer          not null, primary key
#  bpjs_kesehatan       :integer
#  bpjs_ketenagakerjaan :integer
#  gaji_pokok           :integer
#  periode_slip_gaji    :integer
#  pph_21               :integer
#  tunjangan_jabatan    :integer
#  tunjangan_laptop     :integer
#  tunjangan_makan      :integer
#  tunjangan_transport  :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :integer
#
