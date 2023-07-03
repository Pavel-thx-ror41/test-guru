# frozen_string_literal: true

puts "\nSEED"
Faker::Config.locale = :ru
I18n.reload! # https://github.com/faker-ruby/faker/issues/285#issuecomment-65909778
RANDOM_SEED = 2023_07

seeds_data = YAML.safe_load(File.read("db/seeds.yml"))


puts "\nCATEGORIES"
Faker::Config.random = Random.new(RANDOM_SEED)
srand(RANDOM_SEED)
seeds_data['categories'].first(3).each do |category|
  # https://github.com/faker-ruby/faker/wiki/All-functions
  Category
    .where(title: category.values.first['title'])
    .first_or_create
    .update(info: Faker::Lorem.paragraph_by_chars(number: 128))
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
  puts "  U: #{username}"
end


puts "\nTESTS"
Faker::Config.random = Random.new(RANDOM_SEED)
srand(RANDOM_SEED)
Faker::GreekPhilosophers.fetch_all('greek_philosophers.quotes').first(4).each do |title|
  Test
    .where(title: title)
    .first_or_create
    .update(
      user_id: User.all.ids.sample,
      category_id: Category.ids.sample,
      published: Faker::Boolean.boolean,
      level: (1..5).to_a.sample,
      info: Faker::Lorem.paragraph_by_chars(number: 128)
    )
  puts "  T: #{title}"
end


puts "\nQUESTIONS"
Faker::Config.random = Random.new(RANDOM_SEED)
srand(RANDOM_SEED)
Test.all.each do |test|
  puts "  for T: #{test.title}"
  (2..3).to_a.sample.times do
    title = Faker::Hacker.say_something_smart.sub('!', '?')

    Question
      .where(title: title)
      .first_or_create
      .update(
        test_id: test.id,
        info: Faker::Lorem.paragraph_by_chars(number: 128)
      )
    puts "    Q: #{title}"
  end
end


puts "\nANSWERS"
Faker::Config.random = Random.new(RANDOM_SEED)
srand(RANDOM_SEED)
Question.all.each do |question|
  puts "  for Q: #{question.title}"
  (2..3).to_a.sample.times do
    answer = Answer.where(question_id: question.id, title: Faker::Hacker.say_something_smart).first_or_create
    answer.update(info: Faker::Lorem.paragraph_by_chars(number: 128))
    puts "    A: #{answer.title}"
  end
  correct_answer = Answer.where(question_id: question.id).sample
  correct_answer.update(correct: true)
  puts "    CORRECT: #{correct_answer.title}"
end
puts


puts 'PASSES'
Faker::Config.random = Random.new(RANDOM_SEED)
srand(RANDOM_SEED)
3.times do
  pass = Pass
         .where(
           user_id: User.ids.sample,
           test_id: Test.ids.sample,
           pass_start: Faker::Time.between(from: 30.days.ago, to: Date.today)
         )
         .first_or_create
  puts "  Pass for U: #{pass.user.name} on T: #{pass.test.title}"
end
puts

puts 'PASSES CHOICES'
srand(RANDOM_SEED)
Pass.all.each do |pass|
  puts "  Pass for U: #{pass.user.name} on T: #{pass.test.title}"
  pass.test.questions.each do |question|
    choice = Choice
             .where(pass_id: pass.id, question_id: question.id, answer_id: question.answers.ids.sample)
             .first_or_create
    puts "    Q: #{choice.question.title}"
    puts "       #{choice.answer.correct ? 'CORRECT' : 'WRONG'} CHOICE: #{choice.answer.title}"
  end
end
puts
