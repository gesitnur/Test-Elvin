# frozen_string_literal: true

class Admin < ApplicationRecord
  paginates_per 10

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum domain_access: { 'All': 1, 'nineod.com': 2, 'nineodfreight.com': 3, 'elvin.co.id': 4 }

  validates :login_uniq, uniqueness: true

  def self.new_admin(admin_data = {})
    admin_data = { name: Faker::Name.name, password: '12345678' } if admin_data.blank?
    admin_data.merge!({ login_uniq: admin_data[:name].parameterize, domain_access: 1 })

    new_admin = Admin.new(admin_data)

    if new_admin.save
      puts 'Admin successfully created'
      puts "Admin => name: #{new_admin.name}, login_uniq: #{new_admin.login_uniq}, password : #{new_admin.password}"
    else
      puts "Admin => errors: #{new_admin.errors.full_messages.join(', ')}"
    end
  end

  def reset_password
    default_password = '12345678'
    self.password = default_password

    if save
      puts 'Successfully Reset Password'
      puts "login_uniq: #{login_uniq}, password : #{default_password}"
    else
      puts "Admin => errors: #{errors.full_messages.join(', ')}"
    end
  end

  def check_access(domain)
    return true if domain_access.eql?('All')

    domain.eql?(domain_access)
  end

  def domain_access_all
    domain_access.eql?('All')
  end

  def generate_login_uniq(name)
    self.login_uniq = name.parameterize
  end

  protected

  def email_required?
    false
  end
end

# == Schema Information
#
# Table name: admins
#
#  id                     :integer          not null, primary key
#  domain_access          :integer
#  email                  :string           default("")
#  encrypted_password     :string           default(""), not null
#  is_owner               :boolean          default(FALSE)
#  login_uniq             :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admins_on_email                 (email)
#  index_admins_on_login_uniq            (login_uniq) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#
