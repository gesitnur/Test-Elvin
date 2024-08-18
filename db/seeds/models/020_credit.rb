# frozen_string_literal: true

credits = [
  { account_date: Time.now,
    due_date: Time.now + 7.day,
    amount: Faker::Commerce.price,
    client: Faker::Lorem.sentence(word_count: 2),
    description: Faker::Lorem.sentence(word_count: 4),
    currency: Currency.all.sample,
    cash_book: CashBook.all.sample,
    cash_book_category_id: CashBookCategory.income.all.sample.id },
]

puts "\n==> Testing Add Credit"
credits.each do |credit|
  new_credit = Credit.new(credit)

  if new_credit.save
    puts "Credit Added"
  else
    puts "Credit => errors: #{new_credit.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Credit'

# puts "\n==> Testing Validation Credit"
# credit_sample = Credit.all.sample
# new_credit = Credit.create({  name: nil,
#                           email: nil,
#                           company: nil,
#                           position: nil })
# new_credit.errors.full_messages.each do |message|
#   puts "Credit => error: #{message}"
# end
# puts '==> End Testing Validation Credit'

# puts "\n==> Testing Relation Credit - name: #{credit_sample.name}; relation:"
# position = credit_sample.position.name if credit_sample.respond_to?('position')

# puts "Credit => position: #{position}"
# puts '==> end Testing Relation Credit '
