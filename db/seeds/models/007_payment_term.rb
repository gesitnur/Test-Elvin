# frozen_string_literal: true

payment_terms = [
  { name: 'Net 15',
    number_of_day: 15,
    is_master: false },
  { name: 'Net 30',
    number_of_day: 30,
    is_master: false },
  { name: 'Net 45',
    number_of_day: 45,
    is_master: false },
  { name: 'Net 60',
    number_of_day: 60,
    is_master: false },
  { name: 'Due end of the month',
    number_of_day: 0,
    is_master: true },
  { name: 'Due end of next month',
    number_of_day: 0,
    is_master: true },
  { name: 'Due on receipt',
    number_of_day: 0,
    is_master: true },
  { name: 'Custom',
    number_of_day: 0,
    is_master: true }
]

puts "\n==> Testing Add Payment Term"
payment_terms.each do |company|
  new_payment_term = PaymentTerm.new(company)

  if new_payment_term.save
    puts "Payment Term => name: #{new_payment_term.name} Added"
  else
    puts "Payment Term => errors: #{new_payment_term.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Payment Term'

# puts "\n==> Testing Validation company"
# company_sample = PaymentTerm.all.sample
# new_payment_term = PaymentTerm.create({  name: nil,
#                                 number_of_day: nil,
#                                 is_master: nil })
# new_payment_term.errors.full_messages.each do |message|
#   puts "Payment Term => error: #{message}"
# end
# puts '==> End Testing Validation company'

# puts "\n==> Testing Relation Position - name: #{company_sample.name}; relation:"
# users = if company_sample.send(:users).is_a?(ActiveRecord::Associations::CollectionProxy)
#           company_sample.send(:users).first_or_initialize
#         end
# positions = if company_sample.send(:positions).is_a?(ActiveRecord::Associations::CollectionProxy)
#               company_sample.send(:positions).first_or_initialize
#             end

# puts "Position => users: #{users&.name}"
# puts "Position => positions: #{positions&.name}"
# puts '==> end Testing Relation Position'
