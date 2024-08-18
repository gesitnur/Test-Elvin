# frozen_string_literal: true

company = Company.all.sample

# item_type: nil, name: nil, unit: nil, price: nil, description: nil, tax_rate_id: nil,
# company_id: nil, currency_id: ni

items = [
  { item_type: 'Goods',
    name: Faker::IndustrySegments.industry,
    unit: 'box',
    price: 14000,
    description: Faker::Lorem.sentence(word_count: 7),
    tax_rate: TaxRate.all.sample,
    company: Company.all.sample,
    currency: Currency.all.sample },
]

puts "\n==> Testing Add Item"
items.each do |item|
  new_item = Item.new(item)

  if new_item.save
    puts "Item => name: #{new_item.name} Added"
  else
    puts "Item => errors: #{new_item.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Item'

# puts "\n==> Testing Validation item"
# item_sample = Item.all.sample
# new_item = Item.create({  name: nil,
#                           email: nil,
#                           company: nil,
#                           position: nil })
# new_item.errors.full_messages.each do |message|
#   puts "Item => error: #{message}"
# end
# puts '==> End Testing Validation item'

# puts "\n==> Testing Relation Item - name: #{item_sample.name}; relation:"
# position = item_sample.position.name if item_sample.respond_to?('position')

# puts "Item => position: #{position}"
# puts '==> end Testing Relation Item'
