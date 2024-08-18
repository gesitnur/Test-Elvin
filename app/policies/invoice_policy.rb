# frozen_string_literal: true

class InvoicePolicy < ApplicationPolicy
  def index?
    user.position.hrd_invoice(:read)
  end

  def export_pdf?
    user.position.hrd_invoice(:read)
  end

  def new?
    user.position.hrd_invoice(:create)
  end

  def create?
    user.position.hrd_invoice(:create)
  end

  def edit?
    user.position.hrd_invoice(:update)
  end

  def update?
    user.position.hrd_invoice(:update)
  end

  def destroy?
    user.position.hrd_invoice(:delete)
  end
end
