# frozen_string_literal: true

company = Company.all.sample

users = [
  { name: Faker::Name.name,
    email: Faker::Internet.email,
    company: company,
    password: '12345678',
    email_confirmed: true,
    position: Position.all.sample },
  { name: Faker::Name.name,
    email: Faker::Internet.email,
    company: company,
    password: '12345678',
    email_confirmed: true,
    position: Position.all.sample },
  { name: Faker::Name.name,
    email: Faker::Internet.email,
    company: company,
    password: '12345678',
    email_confirmed: true,
    position: Position.all.sample },
  { name: Faker::Name.name,
    email: Faker::Internet.email,
    company: company,
    password: '12345678',
    email_confirmed: true,
    position: Position.all.sample }
]

puts "\n==> Testing Add User"
users.each do |user|
  new_user = User.new(user)

  if new_user.save
    puts "User => name: #{new_user.name}, email : #{new_user.email} Added"
  else
    puts "User => errors: #{new_user.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add User'

puts "\n==> Testing Validation user"
user_sample = User.all.sample
new_user = User.create({  name: nil,
                          email: nil,
                          company: nil,
                          position: nil })
new_user.errors.full_messages.each do |message|
  puts "User => error: #{message}"
end
puts '==> End Testing Validation user'

puts "\n==> Testing Relation User - name: #{user_sample.name}; relation:"
position = user_sample.position.name if user_sample.respond_to?('position')
puts "User => position: #{position}"
company = user_sample.company.name if user_sample.respond_to?('company')
puts "User => Company: #{company}"
puts '==> end Testing Relation User'
