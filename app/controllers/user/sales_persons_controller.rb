# frozen_string_literal: true

class User::SalesPersonsController < User::BaseCrudController

  def create
    super do
      self.redirect_path = user_sales_persons_path
    end
  end

  def update
    super do
      self.redirect_path = user_sales_persons_path
    end
  end

  def destroy
    super do
      self.redirect_path = user_sales_persons_path
    end
  end
end
