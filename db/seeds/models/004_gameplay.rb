# frozen_string_literal: true

gameplays = [
  { name: 'Basic',
    description: Faker::Lorem.sentence(word_count: 30),
    is_basic: true,
    question_essays_attributes: [
      { question: 'Apakah anda kesulitan dalam mempelajari hal baru ?' },
      { question: 'Bagaimana anda menyikapi atau tindakan anda dalam mempelajari hal baru ?',
        option_1: 'Tidak suka mempelajari hal baru',
        option_2: 'Menunggu sekolah atau pengajaran tentang hal baru tersebut',
        option_3: 'Mencari informasi seluas - luas nya di internet',
        option_4: 'Membuat latihan - latihan atau project - project' },
      { question: 'Perkenalkan diri anda menggunakan bahasa inggris' },
      { question: 'Bila anda adalah orang yang tepat, berapa salary yang anda harapkan ?' }
    ] },
  { name: 'Backend',
    description: Faker::Lorem.sentence(word_count: 30),
    question_multiples_attributes: [
      { question: 'Apabila a=7, b=12, maka jika di berikan instruksi a=b; b=a akan mengakibatkan ?',
        option_1: 'a=0 , b=12',
        option_2: 'a=7 , b=12',
        option_3: 'a=7 , b=0',
        option_4: 'a=12 , b=12',
        answer: 'option_2',
        point: 1 }
    ],
    question_essays_attributes: [
      { question: 'Tuliskan Data Array 2 Dimensi !',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },
      { question: 'Tuliskan Looping Statis / Dinamis (menggunakan bahasa pemrograman yang anda kuasai)',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },
      { question: 'Tuliskan Statement IF Bersarang / Bercabang
         (menggunakan bahasa pemrograman yang anda kuasai dan bebas pilih salah satu atau keduanya)',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },
      { question: 'Tuliskan 3 script SQL yang anda kuasai !',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },
      { question: 'Tuliskan SQL script untuk mengambil data dari 3 tabel atau relasi many to many !',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },
      { question: 'Apa anda memahami OOP ? Jelaskan !',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },
      { question: 'Sebutkan 3 website/mobile aplikasi yang paling Anda sukai berikut alasannnya!',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 }
    ] },
  { name: 'Frontend',
    description: Faker::Lorem.sentence(word_count: 30),
    question_essays_attributes: [
      { question: 'Untuk mendeklarasikan bahwa sebuah file HTML adalah HTML5, maka diperlukan sebuah tag, yakni ?',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },
      { question: 'Tag HTML apa saja yang baru ditambahkan di versi HTML5? Jelaskan masing-masing fungsinya !',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },
      { question: 'Sebutkan beberapa cara untuk menghilangkan/menyembunyikan elemen
         HTML dengan menggunakan CSS, dan sebutkan perbedaannya !',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },
      { question: 'Sebutkan CSS framework untuk membuat tampilan responsive,
         serta sebutkan yang pernah Anda pakai !',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },
      { question: 'Berapakah nilai responsive breakpoint yang umum digunakan
         untuk memisahkan tampilan mobile dan desktop ?',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },
      { question: 'Apakah Anda pernah menggunakan property flex di CSS?
         Jika iya, sebutkan keuntungan dan kemudahan dari penggunaan property tersebut !',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },
      { question: 'Terdapat beberapa elemen HTML seperti berikut:
        <div class="code-block">
                <pre data-lllanguage="html" data-llstyle="dark">
                  &lt;div class="features"&gt;
                    &lt;div class="features__items" data-id="5"&gt;Seamless&lt;/div&gt;
                    &lt;div class="features__items" data-id="7"&gt;Dynamic&lt;/div&gt;
                    &lt;div class="features__items" data-id="9"&gt;High Range&lt;/div&gt;
                    &lt;div class="features__items" data-id="12"&gt;Deep Learning&lt;/div&gt;
                  &lt;/div&gt;
                </pre>
              </div>
              Gunakan jQuery selector untuk memilih elemen ‘.features__item’ dengan data-id 7,
               dan berikan class baru "highlighted"!',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 10 }
    ] },
  { name: 'Frontend React',
    description: Faker::Lorem.sentence(word_count: 30),
    question_essays_attributes: [
      { question: 'Menurutmu, apa keuntungan menggunakan ReactJS ?',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },

      { question: 'Apa perbedaan functional dan class component ?',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },

      { question: 'Sebutkan dan jelaskan secara singkat lifecycle yang ada di ReactJS !',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },

      { question: 'Jelaskan secara singkat state dan props !',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },

      { question: 'Bagaimana cara meng-update state ?',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 5 },

      { question: 'Apakah anda pernah menggunakan React Hooks? Jika iya, jelaskan secara singkat apa itu React Hooks !',
        hint_answer: Faker::Lorem.sentence(word_count: 20),
        point: 6 }
    ] }
]

puts "\n==> Testing Add Gameplay"
gameplays.each do |gameplay|
  new_gameplay = Gameplay.new(gameplay)

  if new_gameplay.save
    puts "Gameplay => name: #{new_gameplay.name} Added"
  else
    puts "Gameplay => errors: #{new_gameplay.errors.full_messages.join(', ')}"
  end
end
puts '==> End Testing Add Gameplay'

puts "\n==> Testing Validation Gameplay"
gameplay_sample = Gameplay.all.sample
new_gameplay = Gameplay.create({ name: nil, description: nil })
new_gameplay.errors.full_messages.each do |message|
  puts "Gameplay => error: #{message}"
end
puts '==> End Testing Validation Gameplay'

puts "\n==> Testing Search Gameplay: search gameplay name that contains 'a'"
q = Gameplay.ransack({ name_cont: 'a' })
result = q.result
result.each do |gameplay_record|
  puts "Gameplay => name: #{gameplay_record.name}"
end
puts '==> End Testing Search Gameplay'

puts "\n==> Testing Relation Gameplay - name: #{gameplay_sample.name}; relation:"
interviews = if gameplay_sample.send(:interviews).is_a?(ActiveRecord::Associations::CollectionProxy)
               gameplay_sample.send(:interviews).first_or_initialize
             end
question_multiples = if gameplay_sample.send(:question_multiples).is_a?(ActiveRecord::Associations::CollectionProxy)
                       gameplay_sample.send(:question_multiples).first_or_initialize
                     end
question_essays = if gameplay_sample.send(:question_essays).is_a?(ActiveRecord::Associations::CollectionProxy)
                    gameplay_sample.send(:question_essays).first_or_initialize
                  end

puts "Gameplay => interviews: #{interviews&.name}"
puts "Gameplay => question_multiples: #{question_multiples&.question}"
puts "Gameplay => question_essays: #{question_essays&.question}"
puts '==> end Testing Relation Gameplay'
