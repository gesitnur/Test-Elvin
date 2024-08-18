# frozen_string_literal: true

company = Company.all.sample

# item_type: nil, name: nil, unit: nil, price: nil, description: nil, tax_rate_id: nil,
# company_id: nil, currency_id: ni

tax_rates = [
  { name: Faker::Lorem.sentence(word_count: 3),
    rate: 14 },
]

puts "\n==> Testing Add Tax Rate"
tax_rates.each do |tax_rate|
  new_tax_rate = TaxRate.new(tax_rate)

  if new_tax_rate.save
    puts "Tax Rate => name: #{new_tax_rate.name} Added"
  else
    puts "Tax Rate => errors: #{new_tax_rate.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Tax Rate'

# puts "\n==> Testing Validation Tax Rate"
# tax_rate_sample = TaxRate.all.sample
# new_tax_rate = TaxRate.create({  name: nil,
#                           email: nil,
#                           company: nil,
#                           position: nil })
# new_tax_rate.errors.full_messages.each do |message|
#   puts "Tax Rate => error: #{message}"
# end
# puts '==> End Testing Validation Tax Rate'

# puts "\n==> Testing Relation Tax Rate - name: #{tax_rate_sample.name}; relation:"
# position = tax_rate_sample.position.name if tax_rate_sample.respond_to?('position')

# puts "Tax Rate => position: #{position}"
# puts '==> end Testing Relation Tax Rate '
