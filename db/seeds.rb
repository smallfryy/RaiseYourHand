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
    Group.create(name: Faker::Lorem.word)
  end