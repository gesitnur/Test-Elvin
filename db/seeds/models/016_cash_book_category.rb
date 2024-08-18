# frozen_string_literal: true

cash_book_categories = [
  { name: 'Income 1',
    category_type: 'Income',
    company_id: Company.all.sample.id,
  },
  { name: 'Expense 1',
    category_type: 'Expense',
    company_id: Company.all.sample.id,
  }
]

puts "\n==> Testing Add Cash Book Category"
cash_book_categories.each do |cash_book|
  new_cash_book_category = CashBookCategory.new(cash_book)

  if new_cash_book_category.save
    puts "Cash Book Category => name: #{new_cash_book_category.name} Added"
  else
    puts "Cash Book Category => errors: #{new_cash_book_category.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Cash Book Category'
