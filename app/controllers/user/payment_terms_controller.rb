# frozen_string_literal: true

class User::PaymentTermsController < User::BaseCrudController

  def index
    @payment_terms = @payment_terms.without_master_data
  end

  def create
    super do
      self.redirect_path = user_payment_terms_path
    end
  end

  def update
    super do
      self.redirect_path = user_payment_terms_path
    end
  end
end
