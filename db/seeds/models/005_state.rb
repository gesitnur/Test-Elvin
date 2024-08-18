# frozen_string_literal: true

puts "\n==> Testing Add States"
countries = Country.all
countries.each do |country|
  states_data = CS.states(country.code)
  states_data.each do |state_code, state_name|
    new_state = State.create(code: state_code, name: state_name, country_id: country.id)
    puts "State => #{new_state.name} Added"
  end
end
puts '==> end Testing Add States'

puts "\n==> Testing Validation State"
country = countries.sample
new_state = State.create(name: nil, code: nil, country_id: country)
new_state.errors.full_messages.each do |message|
  puts "State => error: #{message}"
end
puts '==> end Testing Validation State'

# test search with ransack
state_sample = State.all.sample
puts "\n==> Testing Search State: search state name that contains '#{state_sample.name}'"
q = State.ransack({ name_cont: state_sample.name })
result = q.result
result.each do |state_record|
  puts "State => name: #{state_record.name}"
end
puts '==> end Testing Search State'

puts "\n==> Testing Relation State - name: #{state_sample.name}; relation:"
country = state_sample.country.name if state_sample.respond_to?('country')

puts "State => country: #{country}"
puts '==> end Testing Relation State'
