# frozen_string_literal: true

puts "\n==> Testing Add Currencies"
country_codes = %i[AE AU CA CN DE GB IN JP MY SA US ZA ID ]
country_codes.each do |country_code|
  # code: nil, country_id: nil
  country = Country.find_by_code(country_code)
  currency_code = IsoCountryCodes.find(country_code).currency

  new_currency = Currency.create(code: currency_code, symbol: Money::Currency.new(country.currency_code).symbol, country: country)
  puts "Country => #{new_currency.code} Added"
end
puts '==> end Testing Add Currencies'

puts "\n==> Testing Validation Currencies"
new_currency = Currency.create(code: nil)
new_currency.errors.full_messages.each do |message|
  puts "Country => error: #{message}"
end
puts '==> end Testing Validation Currencies'

# test search with ransack
currency_sample = Currency.all.sample
puts "\n==> Testing Search Country: search country name that contains '#{currency_sample.code}'"
q = Currency.ransack({ name_cont: currency_sample.code })
result = q.result
result.each do |country_record|
  puts "Country => name: #{country_record.code}"
end
puts '==> end Testing Search Country'

# puts "\n==> Testing Relation Currencies - name: #{currency_sample.name}; relation:"
# states = currency_sample.states.first_or_initialize if currency_sample.send(:states)
#                                                                     .is_a?(ActiveRecord::Associations::CollectionProxy)
# cities = currency_sample.cities.first_or_initialize if currency_sample.send(:cities)
#                                                                     .is_a?(ActiveRecord::Associations::CollectionProxy)

# puts "Country => states: #{states&.name}"
# puts "Country => cities: #{cities&.name}"
# puts '==> end Testing Relation Currencies'
