# frozen_string_literal: true

puts "\n==> Testing Add Countries"
country_datas = ISO3166::Country.all
country_datas.each do |country_data|
  new_country = Country.create(code: country_data.alpha2, name: country_data.iso_short_name, currency_code: country_data.currency_code)
  puts "Country => #{new_country.name} Added"
end
puts '==> end Testing Add Countries'

puts "\n==> Testing Validation Countries"
new_country = Country.create(name: nil, code: nil)
new_country.errors.full_messages.each do |message|
  puts "Country => error: #{message}"
end
puts '==> end Testing Validation Countries'

# test search with ransack
country_sample = Country.all.sample
puts "\n==> Testing Search Country: search country name that contains '#{country_sample.name}'"
q = Country.ransack({ name_cont: country_sample.name })
result = q.result
result.each do |country_record|
  puts "Country => name: #{country_record.name}"
end
puts '==> end Testing Search Country'

puts "\n==> Testing Relation Countries - name: #{country_sample.name}; relation:"
states = country_sample.states.first_or_initialize if country_sample.send(:states)
                                                                    .is_a?(ActiveRecord::Associations::CollectionProxy)

puts "Country => states: #{states&.name}"
puts '==> end Testing Relation Countries'
