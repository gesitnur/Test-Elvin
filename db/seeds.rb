# frozen_string_literal: true

class SeedDecorator
  class << self
    def devider(text = '', devider_char = '-')
      puts text.ljust(107, devider_char)
    end

    def right_border(text = '')
      puts "#{text.ljust(105, ' ')} |"
    end

    def whitespace
      puts "\n\n\n"
    end

    def record_inspector(record)
      texts = record.attributes.inspect.scan(/.{1,105}/)
      texts.map { |txt| right_border(txt) }
      right_border
      devider
      whitespace
    end
  end
end

[Rails.env].each do |seed|
  seed_file = "#{Rails.root}/db/seeds/#{seed}.rb"
  next unless File.exist?(seed_file)

  puts "*** Loading #{seed} seed data"
  require seed_file
  puts "*** #{seed} seed data Loaded"
end
