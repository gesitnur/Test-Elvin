# frozen_string_literal: true

class ContactRequestsController < ActionController::Base
  def create
    @contact_request = ContactRequest.new(contact_request_params)
    @contact_request.save

    respond_to do |format|
      format.js
    end
  end

  private

  def contact_request_params
    params.require(:contact_request).permit(:name, :email, :subject, :message, :domain_request)
  end
end
