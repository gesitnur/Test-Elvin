# frozen_string_literal: true

class Nineod::HomeController < ApplicationController
  layout 'application_nineod'

  def index
    @contact_request = ContactRequest.new
  end

  def website_builder; end

  def platform_builder; end

  def custom_web_app; end

  def services; end

  def links
    render "links", layout: false
  end
end
