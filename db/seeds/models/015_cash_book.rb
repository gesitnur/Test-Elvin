# frozen_string_literal: true

cash_books = [
  { name: Faker::Lorem.sentence(word_count: 2),
    description: Faker::Lorem.sentence(word_count: 5),
    start_balance: Faker::Commerce.price,
    company: Company.all.sample,
    currency: Currency.all.sample },
]

puts "\n==> Testing Add Cash Book"
cash_books.each do |cash_book|
  new_cash_book = CashBook.new(cash_book)

  if new_cash_book.save
    puts "Cash Book => name: #{new_cash_book.name} Added"
  else
    puts "Cash Book => errors: #{new_cash_book.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Cash Book'

# puts "\n==> Testing Validation Cash Book"
# cash_book_sample = CashBook.all.sample
# new_cash_book = CashBook.create({  name: nil,
#                           email: nil,
#                           company: nil,
#                           position: nil })
# new_cash_book.errors.full_messages.each do |message|
#   puts "Cash Book => error: #{message}"
# end
# puts '==> End Testing Validation Cash Book'

# puts "\n==> Testing Relation Cash Book - name: #{cash_book_sample.name}; relation:"
# position = cash_book_sample.position.name if cash_book_sample.respond_to?('position')

# puts "Cash Book => position: #{position}"
# puts '==> end Testing Relation Cash Book '
