require 'faker'
  Faker::Config.locale = :en
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
    Tag.create(name: Faker::Company.buzzword)
  end

  20.times do
    name = Faker::Name.first_name
    User.create(name: name, email: "#{name}@test.com", password: "password", password_confirmation: "password")
  end

  10.times do
    Group.create(name: Faker::Lorem.word, description: Faker::Lorem.paragraph)
    admin_id = Faker::Number.between(from = 1, to = 20)
    status = Status.create(user_id: admin_id, group_id: Group.all.last.id, status: "admin")
    Group.all.last.statuses << status
    5.times do
      user_id = Faker::Number.between(from = 1, to = 20)
      unless(Group.all.last.users.map{|user| user.id}.include?(user_id))
        status = Status.create(user_id: user_id, group_id: Group.all.last.id, status: "member")
        Group.all.last.statuses << status
      end
      3.times do
        question = Question.create(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph, group_id: Group.all.last.id, user_id: User.all.last.id, created_at: DateTime.now - Faker::Number.between(from = 1, to = 20))
        Faker::Number.between(from = 1, to = 4).times do
          question.tags << Tag.find(Faker::Number.between(from = 1, to = 10))
        end
        question.save
      end
      3.times do 
        q = Group.all.last.questions.sample
        u = Group.all.last.users.sample
        answer = Answer.create(question_id: q.id, user_id: u.id, content: Faker::Lorem.paragraph)
        q.answers << answer
      end
    end
  end