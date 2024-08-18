# frozen_string_literal: true

class User::GameplaysController < User::BaseCrudController

  self.additional_parameters = [:is_basic, question_multiples_attributes: %i[id question question_type option_1 option_2
                                                                  option_3 option_4 answer point _destroy],
                                           question_essays_attributes: %i[id question question_type
                                                                          hint_answer point _destroy]]
  self.init_relations = {
    has_one: [],
    has_many: %i[question_multiples question_essays]
  }

end
