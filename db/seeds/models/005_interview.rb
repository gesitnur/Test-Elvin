# frozen_string_literal: true

interviews = [
  { name: Faker::Name.name,
    graduated: Faker::Lorem.sentence(word_count: 2),
    major: Faker::Lorem.sentence(word_count: 3),
    gender: 'Man',
    date_of_birth: Time.zone.now - 20.year,
    apply_for_job: 'Frontend',
    domicile: Faker::Address.city,
    phone_number: Faker::Number.leading_zero_number(digits: 12),
    email: Faker::Internet.email,
    scheduled_interview: Time.zone.now + 1.day,
    work_experience: Faker::Lorem.paragraph(sentence_count: 4),
    interview_link: Faker::Internet.domain_name,
    gameplay_ids: [Gameplay.all.sample.id] },
  { name: Faker::Name.name,
    graduated: Faker::Lorem.sentence(word_count: 2),
    major: Faker::Lorem.sentence(word_count: 3),
    gender: 'Woman',
    date_of_birth: Time.zone.now - 18.year,
    apply_for_job: 'Backend',
    domicile: Faker::Address.city,
    phone_number: Faker::Number.leading_zero_number(digits: 12),
    email: Faker::Internet.email,
    scheduled_interview: Time.zone.now + 4.day,
    work_experience: Faker::Lorem.paragraph(sentence_count: 4),
    interview_link: Faker::Internet.domain_name,
    gameplay_ids: [Gameplay.all.sample.id] }
]

puts "\n==> Testing Add Interview"
interviews.each do |interview|
  new_interview = Interview.new(interview)

  if new_interview.save
    puts "Interview => name: #{new_interview.name}, email : #{new_interview.email} Added"
  else
    puts "Interview => errors: #{new_interview.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Interview'

puts "\n==> Testing Validation Interview"
new_interview = Interview.create({  name: nil,
                                    graduated: nil,
                                    major: nil,
                                    gender: nil,
                                    date_of_birth: nil,
                                    apply_for_job: nil,
                                    domicile: nil,
                                    phone_number: nil,
                                    email: nil,
                                    scheduled_interview: nil,
                                    work_experience: nil,
                                    interview_link: nil })
new_interview.errors.full_messages.each do |message|
  puts "Interview => error: #{message}"
end
puts '==> End Testing Validation Interview'

puts "\n==> Testing Search Interview: search interview name that contains 'a'"
q = Interview.ransack({ name_cont: 'a' })
result = q.result
result.each do |interview_record|
  puts "Interview => name: #{interview_record.name}"
end
puts '==> End Testing Search Interview'

interview_sample = Interview.all.sample

puts "\n==> Testing Relation Interview - name: #{interview_sample.name}; relation:"
interview_answers = if interview_sample.send(:interview_answers).is_a?(ActiveRecord::Associations::CollectionProxy)
                      interview_sample.send(:interview_answers).first_or_initialize
                    end
gameplays = if interview_sample.send(:gameplays).is_a?(ActiveRecord::Associations::CollectionProxy)
              interview_sample.send(:gameplays).first_or_initialize
            end

puts "Interview => interview_answers: #{interview_answers&.answer}"
puts "Interview => gameplays: #{gameplays&.name}"
puts '==> end Testing Relation Interview'
