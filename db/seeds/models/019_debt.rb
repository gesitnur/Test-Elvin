  # frozen_string_literal: true

debts = [
  { account_date: Time.now,
    due_date: Time.now + 7.day,
    amount: Faker::Commerce.price,
    client: Faker::Lorem.sentence(word_count: 2),
    description: Faker::Lorem.sentence(word_count: 4),
    currency: Currency.all.sample,
    cash_book: CashBook.all.sample,
    cash_book_category_id: CashBookCategory.income.all.sample.id },
]

puts "\n==> Testing Add Debt"
debts.each do |debt|
  new_debt = Debt.new(debt)

  if new_debt.save
    puts "Debt Added"
  else
    puts "Debt => errors: #{new_debt.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Debt'

# puts "\n==> Testing Validation Debt"
# debt_sample = Debt.all.sample
# new_debt = Debt.create({  name: nil,
#                           email: nil,
#                           company: nil,
#                           position: nil })
# new_debt.errors.full_messages.each do |message|
#   puts "Debt => error: #{message}"
# end
# puts '==> End Testing Validation Debt'

# puts "\n==> Testing Relation Debt - name: #{debt_sample.name}; relation:"
# position = debt_sample.position.name if debt_sample.respond_to?('position')

# puts "Debt => position: #{position}"
# puts '==> end Testing Relation Debt '
