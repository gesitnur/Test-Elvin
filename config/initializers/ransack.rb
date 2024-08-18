# frozen_string_literal: true

Ransack.configure do |config|
  config.add_predicate 'between', {
    arel_predicate: 'between',
    formatter: proc { |value|
      date_data = between_date_formater(value)
      OpenStruct.new(begin: date_data[:begin_date], end: date_data[:end_date])
    },
    validator: proc { |v| v.present? },
    type: :string
  }

  config.add_predicate 'date_equals', {
    arel_predicate: 'eq',
    formatter: proc { |value|
      date_formater_ransack(value)
    },
    validator: proc { |v| v.present? },
    compounds: true,
    type: :date
  }
end

def between_date_formater(date_range = '')
  dates = date_range.split(' - ')
  { begin_date: dates[0].to_date.beginning_of_day, end_date: dates[1].to_date.end_of_day }
rescue StandardError
  { begin_date: DateTime.now.beginning_of_day, end_date: DateTime.now.end_of_day }
end

def date_formater_ransack(date = '')
  date.to_date.to_fs(:db)
rescue StandardError
  Date.today.to_fs(:db)
end
