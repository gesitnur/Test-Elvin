# frozen_string_literal: true

surveys = [
  { title: Time.now,
    description: Time.now + 7.day,
    period: 2,
  }
]

puts "\n==> Testing Add Survey"
surveys.each do |survey|
  new_survey = Survey.new(survey)

  if new_survey.save
    puts "Survey => title: #{new_survey.title} Added"
  else
    puts "Survey => errors: #{new_survey.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Survey'
