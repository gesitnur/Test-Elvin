# frozen_string_literal: true

company = Company.all.sample

# item_type: nil, name: nil, unit: nil, price: nil, description: nil, sales_person_id: nil,
# company_id: nil, currency_id: ni

sales_persons = [
  { name: Faker::Name.name,
    email: Faker::Internet.email },
]

puts "\n==> Testing Add Sales Person"
sales_persons.each do |sales_person|
  new_sales_person = SalesPerson.new(sales_person)

  if new_sales_person.save
    puts "Sales Person => name: #{new_sales_person.name} Added"
  else
    puts "Sales Person => errors: #{new_sales_person.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Sales Person'

# puts "\n==> Testing Validation Sales Person"
# sales_person_sample = SalesPerson.all.sample
# new_sales_person = SalesPerson.create({  name: nil,
#                           email: nil,
#                           company: nil,
#                           position: nil })
# new_sales_person.errors.full_messages.each do |message|
#   puts "Sales Person => error: #{message}"
# end
# puts '==> End Testing Validation Sales Person'

# puts "\n==> Testing Relation Sales Person - name: #{sales_person_sample.name}; relation:"
# position = sales_person_sample.position.name if sales_person_sample.respond_to?('position')

# puts "Sales Person => position: #{position}"
# puts '==> end Testing Relation Sales Person '
