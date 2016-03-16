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
  30.times do 
    Tag.create(name: Faker::Company.buzzword)
  end

  20.times do
    User.create(name: Faker::Name.first_name, email: Faker::Internet.email, password: "password", password_confirmation: "password")
  end

  10.times do
    Group.create(name: Faker::Lorem.word, description: Faker::Lorem.paragraph)
    admin_id = Faker::Number.between(from = 1, to = 20)
    status = Status.create(user_id: admin_id, group_id: Group.all.last.id, status: "admin")
    Group.all.last.statuses << status
  end

  100.times do 
    question = Question.create(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph, group_id: Faker::Number.between(from = 1, to = 10), user_id: Faker::Number.between(from = 1, to = 20))
    Faker::Number.between(from = 1, to = 4).times do
      question.tags << Tag.find(Faker::Number.between(from = 1, to = 30))
    end
    question.save
  end