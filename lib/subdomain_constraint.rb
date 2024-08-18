# frozen_string_literal: true

class SubdomainConstraint
  def initialize(subdomain)
    @domains = [subdomain].flatten
  end

  def matches?(request)
    @domains.include? request.subdomain
  end
end
