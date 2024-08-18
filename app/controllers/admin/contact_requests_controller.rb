# frozen_string_literal: true

class Admin::ContactRequestsController < Admin::BaseController

  def index
    @domain_requests  = ContactRequest.domain_requests
    @contact_requests = if current_admin.domain_access.eql?('All')
                          ContactRequest.all
                        else
                          ContactRequest.where(domain_request: current_admin.domain_access)
                        end

    params[:q] ||= {}

    @q = @contact_requests.ransack(params[:q])
    @contact_requests = @q.result.order_asc.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @contact_request = ContactRequest.find(params[:id])
    @contact_request.read_message
  end
end
