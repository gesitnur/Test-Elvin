# frozen_string_literal: true

class UserMailer < ActionMailer::Base
  default from: 'admin@example.com'

  def registration_confirmation(user, host)
    @user = user
    ActionMailer::Base.default_url_options[:host] = "#{user.company.slug}.#{host}"
    user_email = @user.email
    mail(to: user_email, subject: 'Registration Confirmation')
  end
end
