# frozen_string_literal: true

class NineodFreight::HomeController < ApplicationController
  layout 'application_nineod_freight'

  def index; end

  def about_us; end

  def service; end

  def contact
    @contact_request = ContactRequest.new
  end
end
