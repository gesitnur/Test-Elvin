# frozen_string_literal: true

class User::CashBookCategoriesController < User::BaseCrudController
  before_action :form_collection, only: %i[index create update destroy]

  private

  def form_collection
    set_variable(resources_name, load_resources)
    @expenses = @cash_book_categories.where(category_type: 'Expense')
    @incomes = @cash_book_categories.where(category_type: 'Income')
    @category = CashBookCategory.new
  end
end
