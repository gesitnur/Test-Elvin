# frozen_string_literal: true

class Interview < ApplicationRecord
  paginates_per 10

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :interview_answers, dependent: :destroy
  has_many :interview_gameplays, dependent: :destroy
  has_many :gameplays, through: :interview_gameplays

  enum gender: { 'Man': 0, 'Woman': 1 }
  enum apply_for_job: { 'Frontend': 0, 'Backend': 1 }

  validates :name, :graduated, :gender, :date_of_birth, :apply_for_job, :domicile, :phone_number,
            :email, :scheduled_interview, :work_experience, presence: true
  validates :phone_number, numericality: { only_integer: true }

  validate :scheduled_interview_date
  # validates :login_uniq, uniqueness: true
  before_create :generate_password
  after_create :generate_login_uniq

  def set_completed_gameplay
    interview_gameplays.each.map(&:set_completed)
  end

  def completed_gameplay?
    interview_gameplays.each do |interview_gameplay|
      return false unless interview_gameplay.completed?
    end

    true
  end

  def scheduled_interview_date
    return if scheduled_interview.blank?

    return unless scheduled_interview <= DateTime.now

    errors.add :scheduled_interview, ' must be greater than current time'
  end

  def generate_login_uniq
    self.login_uniq = name.parameterize
    self.save
  end

  def generate_password
    self.password = "12345678"
  end

  def password_required?
    false
  end
end

# == Schema Information
#
# Table name: interviews
#
#  id                     :integer          not null, primary key
#  apply_for_job          :integer
#  date_of_birth          :date
#  domicile               :string
#  email                  :string
#  encrypted_password     :string
#  fresh_graduated        :boolean
#  gender                 :integer
#  graduated              :text
#  hrd_notes              :text
#  interview_link         :text
#  is_training            :boolean
#  is_trial               :boolean
#  login_uniq             :string
#  major                  :string
#  name                   :string
#  notes_before_started   :text
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  scheduled_interview    :datetime
#  training_duration      :integer
#  trial_duration         :integer
#  work_experience        :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_interviews_on_encrypted_password  (encrypted_password) UNIQUE
#  index_interviews_on_login_uniq          (login_uniq) UNIQUE
#
