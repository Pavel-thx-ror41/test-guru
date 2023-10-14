# frozen_string_literal: true

# bin/rails db:drop db:create db:migrate db:seed

puts "\nSEED"
Faker::Config.locale = :ru
I18n.reload! # https://github.com/faker-ruby/faker/issues/285#issuecomment-65909778
RANDOM_SEED = 2023_07

seeds_data = YAML.safe_load(File.read("db/seeds.yml"))


puts "\nCATEGORIES"
Faker::Config.random = Random.new(RANDOM_SEED)
seeds_data['categories'].each do |category|
  # https://github.com/faker-ruby/faker/wiki/All-functions
  Category.create!(title: category.values.first['title'], info: Faker::Lorem.paragraph_by_chars(number: 128))
  puts "  C: #{category.values.first['title']}"
end


puts "\nUSERS"
Faker::Config.random = Random.new(RANDOM_SEED)
srand(RANDOM_SEED)
5.times do
  full_name = Russian.transliterate([
    [Faker::Name.female_first_name, Faker::Name.female_last_name],
    [Faker::Name.male_first_name, Faker::Name.male_last_name]
  ].sample.join(' ')).split(' ')

  # gems/faker-3.2.0/lib/faker/default/internet.rb
  email = Faker::Internet.email(name: full_name[0], domain: full_name[1])
  pass = Faker::Lorem.characters(number: User.password_length.last / 20)
  User.create!(email: email, password: pass, password_confirmation: pass, confirmed_at: Time.now - 1.day)
  puts "  U: #{email}"
end


puts "\nTESTS"
Faker::Config.random = Random.new(RANDOM_SEED)
srand(RANDOM_SEED)
Faker::GreekPhilosophers.fetch_all('greek_philosophers.quotes').each do |title|
  Test.create!(
    title: title,
    user_id: User.all.ids.sample,
    category_id: Category.ids.sample,
    published: Faker::Boolean.boolean,
    level: (1..7).to_a.sample,
    info: Faker::Lorem.paragraph_by_chars(number: 128)
  )
  puts "  T: #{title}"
end


puts "\nQUESTIONS"
Faker::Config.random = Random.new(RANDOM_SEED)
srand(RANDOM_SEED)
Test.all.each do |test|
  puts "  for T: #{test.title}"
  (2..7).to_a.sample.times do
    title = Faker::Hacker.say_something_smart.sub('!', '?')
    Question.create!(test_id: test.id, title: title, info: Faker::Lorem.paragraph_by_chars(number: 128))
    puts "    Q: #{title}"
  end
end


puts "\nANSWERS"
Faker::Config.random = Random.new(RANDOM_SEED)
srand(RANDOM_SEED)
Question.all.each do |question|
  puts "  for Q: #{question.title}"
  (2..4).to_a.sample.times do
    correct = Faker::Boolean.boolean
    title = Faker::Hacker.say_something_smart.sub('!', '.').sub('?', '.')
    answer = Answer.create!(
      question_id: question.id,
      correct: correct,
      title: correct ? "+ #{title}" : "- #{title}",
      info: Faker::Lorem.paragraph_by_chars(number: 128)
    )
    puts "    A: #{answer.title}"
  end
end
puts
