# frozen_string_literal: true

companies = [
  { name: Faker::Company.name,
    address: Faker::Address.street_address,
    employee_range: 2 },
  { name: Faker::Company.name,
    address: Faker::Address.street_address,
    employee_range: 3 },
  { name: Faker::Company.name,
    address: Faker::Address.street_address,
    employee_range: 2 },
  { name: Faker::Company.name,
    address: Faker::Address.street_address,
    employee_range: 1 },
  { name: Faker::Company.name,
    address: Faker::Address.street_address,
    employee_range: 3 }
]

puts "\n==> Testing Add Company"
companies.each do |company|
  new_company = Company.new(company)

  if new_company.save
    puts "Company => name: #{new_company.name} Added"
  else
    puts "Company => errors: #{new_company.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Company'

puts "\n==> Testing Validation company"
company_sample = Company.all.sample
new_company = Company.create({  name: nil,
                                address: nil,
                                employee_range: nil })
new_company.errors.full_messages.each do |message|
  puts "Company => error: #{message}"
end
puts '==> End Testing Validation company'

puts "\n==> Testing Relation Company - name: #{company_sample.name}; relation:"
users = if company_sample.send(:users).is_a?(ActiveRecord::Associations::CollectionProxy)
          company_sample.send(:users).first_or_initialize
        end

puts "Company => users: #{users&.name}"
puts '==> end Testing Relation Company'
