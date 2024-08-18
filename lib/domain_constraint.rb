# frozen_string_literal: true

class DomainConstraint
  def initialize(domain)
    @domains = [domain].flatten
  end

  def matches?(request)
    (@domains.include? request.domain) && request.subdomain != 'admin'
  end
end
