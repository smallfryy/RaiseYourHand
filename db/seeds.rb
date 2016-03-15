require 'faker'
  # 10.times do 
  #   Question.create(title: Faker::Lorem.sentence, content: Faker::Lorem.sentence)
  # end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# #
#     g = Group.new(name: Faker::Lorem.word)
#     g.save
#     fake_groups = Faker::Lorem.words(10)
#     fake_groups.each do
  10.times do
    Group.create(name: Faker::Lorem.word, description: Faker::Lorem.paragraph)
  end

  20.times do
    User.create(name: Faker::Name.first_name, email: Faker::Internet.email, password: Faker::Internet.password(6, 15))
  end

  100.times do 
    Question.create(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph, group_id: Faker::Number.between(from = 1, to = 10), user_id: Faker::Number.between(from = 1, to = 10))
  end