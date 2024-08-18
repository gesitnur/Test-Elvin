# frozen_string_literal: true

class UsersController < ApplicationController
  def confirm_email
    user = User.find_by_confirm_token(params[:id])

    if user
      user.email_activate
      flash[:notice] = 'Welcome! Your email has been confirmed.
      Please sign in to continue.'
      redirect_to new_user_session_path
    else
      flash[:alert] = 'Sorry. User does not exist'
      redirect_to '/'
    end
  end
end
