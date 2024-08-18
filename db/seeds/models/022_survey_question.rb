# frozen_string_literal: true

survey_questions = [
  { question: Time.now,
    description: Time.now + 7.day,
    question_type: 2,
    survey: Survey.first,
  }
]

puts "\n==> Testing Add Survey Question"
survey_questions.each do |survey_question|
  new_survey_question = SurveyQuestion.new(survey_question)

  if new_survey_question.save
    puts "Survey Question => question: #{new_survey_question.question} Added"
  else
    puts "Survey Question => errors: #{new_survey_question.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Survey Question'
