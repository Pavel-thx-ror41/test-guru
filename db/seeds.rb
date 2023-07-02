# frozen_string_literal: true

puts "\nSEED"
Faker::Config.locale = :ru
I18n.reload! # https://github.com/faker-ruby/faker/issues/285#issuecomment-65909778
FAKER_SEED = 2023_07_01

seeds_data = YAML.safe_load(File.read("db/seeds.yml"))


puts "\nCATEGORIES"
seeds_data['categories'].each do |category|
  # https://github.com/faker-ruby/faker/wiki/All-functions
  Category
    .where(title: category.values.first['title'])
    .first_or_create
    .update(info: Faker::Lorem.paragraph_by_chars(number: 128))
  puts "  Category: #{category.values.first['title']}"
end


puts "\nUSERS"
Faker::Config.random = Random.new(FAKER_SEED)
7.times do
  full_name = Russian.transliterate([
    [Faker::Name.female_first_name, Faker::Name.female_last_name],
    [Faker::Name.male_first_name, Faker::Name.male_last_name]
  ].sample.join(' ')).split(' ')

  # gems/faker-3.2.0/lib/faker/default/internet.rb
  username = Faker::Internet.username(specifier: full_name.join('_'), separators: '_')
  email = Faker::Internet.email(name: full_name[0], domain: full_name[1])

  User
    .where(name: username)
    .first_or_create
    .update(
      email: email,
      password_digest: Faker::Lorem.characters(number: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED),
      password_reset_token: nil,
      info: Faker::Lorem.paragraph_by_chars(number: 128)
    )
  puts "  User: #{username}"
end


puts "\nTESTS"
Faker::GreekPhilosophers.fetch_all('greek_philosophers.quotes').each do |title|
  Test
    .where(title: title)
    .first_or_create
    .update(
      user_id: User.all.ids.sample,
      category_id: Category.ids.sample,
      published: [[false], [true] * 7].flatten.sample,
      level: (1..5).to_a.sample,
      info: Faker::Lorem.paragraph_by_chars(number: 128)
    )
  puts "  Test: #{title}"
end


print "\nQUESTIONS"
Faker::Config.random = Random.new(FAKER_SEED)
Test.ids.each do |test_id|
  print "\n  for Test: #{Test.find(test_id).title}"
  (3..7).to_a.sample.times do
    title = Faker::Hacker.say_something_smart
    Question
      .where(title: title)
      .first_or_create
      .update(
        test_id: test_id,
        info: Faker::Lorem.paragraph_by_chars(number: 128)
      )
    print '.'
  end
end


puts "\n\nANSWERS\n"
Faker::Config.random = Random.new(FAKER_SEED)
total = Question.count
Question.ids.each_with_index do |question_id, index|
  print "  for Question: ##{index + 1} / #{total}     \r"
  (3..5).to_a.sample.times do
    title = Faker::Hacker.say_something_smart
    Answer
      .where(title: title)
      .first_or_create
      .update(
        question_id: question_id,
        info: Faker::Lorem.paragraph_by_chars(number: 128)
      )
  end
  Answer.where(question_id: question_id).sample.update(correct: true)
end

puts "\n"
