# frozen_string_literal: true

seed_names = %w[000_clean_data 001_position 002_company 003_user 004_gameplay 005_interview 004_country 005_state 006_currency 007_payment_term
                011_item 012_tax_rate 013_sales_person 015_cash_book 016_cash_book_category 019_debt 020_credit 021_survey 022_survey_question]

seed_files = seed_names.map do |seed_name|
  Dir.glob("#{Rails.root}/db/seeds/models/#{seed_name}.rb").last
end

seed_files.each do |seed_file|
  next unless File.exist?(seed_file)

  seed_name = seed_file.split('/').last.gsub('.rb', '').titleize
  puts "\n====> Loading #{seed_name} data"
  require seed_file
  puts "\n====> #{seed_name} data Loaded"
end
