# frozen_string_literal: true

# HRD
hrd_position = Position.hrd_level
hrd_position[:invoice] = 1
hrd_position[:absence] = 1
hrd_position[:worker] = 1
hrd_position[:work_relation] = 1
hrd_position[:company_setting] = 13

hrd_emp_position = Position.emp_level
hrd_emp_position[:absence] = 1
hrd_emp_position[:gaiya] = 1

# training
training_emp_position = Position.emp_level
training_emp_position[:absence] = 1
training_emp_position[:gaiya] = 8

# employee
employee_hrd_position = Position.hrd_level
employee_hrd_position[:invoice] = 13
employee_hrd_position[:work_relation] = 13

employee_emp_position = Position.emp_level
employee_emp_position[:absence] = 11
employee_emp_position[:gaiya] = 8

# Team lead
lead_hrd_position = Position.hrd_level
lead_hrd_position[:invoice] = 13
lead_hrd_position[:work_relation] = 13

lead_emp_position = Position.emp_level
lead_emp_position[:absence] = 11
lead_emp_position[:gaiya] = 8

# CTO
cto_hrd_position = Position.hrd_level
cto_hrd_position[:invoice] = 1
cto_hrd_position[:absence] = 1
cto_hrd_position[:worker] = 1
cto_hrd_position[:work_relation] = 1
cto_hrd_position[:company_setting] = 13

cto_emp_position = Position.emp_level
cto_emp_position[:absence] = 11
cto_emp_position[:gaiya] = 8

# CTO
ceo_hrd_position = Position.hrd_level
ceo_hrd_position[:invoice] = 1
ceo_hrd_position[:absence] = 1
ceo_hrd_position[:worker] = 1
ceo_hrd_position[:work_relation] = 1
ceo_hrd_position[:company_setting] = 13

ceo_emp_position = Position.emp_level
ceo_emp_position[:absence] = 11
ceo_emp_position[:gaiya] = 8

positions = [
  { name: 'Owner',
    position_type: 'Super Admin',
    position_access: { hrd: {}, emp: {}, owner: true } },

  { name: 'HRD',
    position_type: 'App Organizer',
    position_access: { hrd: hrd_position, emp: hrd_emp_position, owner: false } },
  { name: 'Training',
    position_type: 'Employee',
    position_access: { hrd: Position.hrd_level, emp: training_emp_position, owner: false } },
  { name: 'Employee',
    position_type: 'Employee',
    position_access: { hrd: employee_hrd_position, emp: employee_emp_position, owner: false } },
  { name: 'Team Lead',
    position_type: 'App Organizer',
    position_access: { hrd: lead_hrd_position, emp: lead_emp_position, owner: false } },
  { name: 'CTO',
    position_type: 'App Organizer',
    position_access: { hrd: cto_hrd_position, emp: cto_emp_position, owner: false } },
  { name: 'CEO',
    position_type: 'App Organizer',
    position_access: { hrd: ceo_hrd_position, emp: ceo_emp_position, owner: false } }
]

puts "\n==> Testing Add Position"
positions.each do |position|
  new_position = Position.new(position)
  if new_position.save
    puts "Position => name: #{new_position.name} Added"
  else
    puts "Position => errors: #{new_position.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Position'

puts "\n==> Testing Validation Position"
position_sample = Position.all.sample
new_position = Position.create({  name: nil,
                                  position_access: nil })
new_position.errors.full_messages.each do |message|
  puts "Position => error: #{message}"
end
puts '==> End Testing Validation Position'

puts "\n==> Testing Relation Venue - name: #{position_sample.name}; relation:"
company = position_sample.company&.name if position_sample.respond_to?('company')
users = if position_sample.send(:users).is_a?(ActiveRecord::Associations::CollectionProxy)
          position_sample.send(:users).first_or_initialize
        end

puts "Venue => company: #{company}"
puts "Venue => users: #{users&.name}"
puts '==> end Testing Relation Venue'
