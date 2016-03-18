# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

describe "Tag" do 
  it "is invaid without name" do 
    tag1 = Tag.create(name: nil)
    tag2 = Tag.create(name: "")
    tag3 = Tag.create(name: "This is my tag.")

    expect(tag1.errors.full_messages).to include "Name can't be blank"
    expect(tag2.errors.full_messages).to include "Name can't be blank"
    expect(tag3.errors.full_messages).to_not include "Name can't be blank"
  end
end

describe ".most_popular_by_questions" do
  it "knows tag with most questions" do
    tag1 = Tag.create(name: "popular")
    tag2 = Tag.create(name: "whatever")
    group1 = Group.create(name: "group 1", description: "....")
    user1 = User.create(name: "My Name", email: "email@email.com", password: "password", password_confirmation: "password")
    question1 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["1"])
    question2 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["1"])
    question3 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["2"])
    expect(Tag.most_popular_by_questions).to eq(tag1)
  end
end

describe ".most_answered" do
  it "knows tag with most answers" do
    tag1 = Tag.create(name: "popular")
    tag2 = Tag.create(name: "whatever")
    group1 = Group.create(name: "group 1", description: "....")
    user1 = User.create(name: "My Name", email: "email@email.com", password: "password", password_confirmation: "password")
    question1 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["1"])
    question2 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["2"])
    answer1 = Answer.create(content: "....", user_id: "1", question_id: "1")
    answer2 = Answer.create(content: "....", user_id: "1", question_id: "2")
    answer3 = Answer.create(content: "....", user_id: "1", question_id: "2")
    expect(Tag.most_answered).to eq(tag2)
  end
end

describe ".least_answered" do
  it "knows tag with most answers" do
    tag1 = Tag.create(name: "popular")
    tag2 = Tag.create(name: "whatever")
    group1 = Group.create(name: "group 1", description: "....")
    user1 = User.create(name: "My Name", email: "email@email.com", password: "password", password_confirmation: "password")
    question1 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["1"])
    question2 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["2"])
    answer1 = Answer.create(content: "....", user_id: "1", question_id: "1")
    answer2 = Answer.create(content: "....", user_id: "1", question_id: "2")
    answer3 = Answer.create(content: "....", user_id: "1", question_id: "2")
    expect(Tag.least_answered).to eq(tag1)
  end
end

describe ".most_popular_by_users" do
  it "knows tag with most unique users" do
    tag1 = Tag.create(name: "popular")
    tag2 = Tag.create(name: "whatever")
    group1 = Group.create(name: "group 1", description: "....")
    user1 = User.create(name: "My Name", email: "email@email.com", password: "password", password_confirmation: "password")
    user2 = User.create(name: "My Name2", email: "email2@email.com", password: "password", password_confirmation: "password")
    user3 = User.create(name: "My Name3", email: "email3@email.com", password: "password", password_confirmation: "password")

    question1 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["1"])
    question2 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "2", tag_ids: ["2"])
    question3 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "3", tag_ids: ["2"])
    question4 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["1"])
    question5 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["1"])

    answer1 = Answer.create(content: "....", user_id: "1", question_id: "1")
    answer2 = Answer.create(content: "....", user_id: "1", question_id: "2")
    answer3 = Answer.create(content: "....", user_id: "1", question_id: "2")
    expect(Tag.most_popular_by_users).to eq(tag2)
  end
end

describe ".trending_tag" do
  it "knows tag with most questions in the past week" do
    tag1 = Tag.create(name: "popular")
    tag2 = Tag.create(name: "whatever")
    group1 = Group.create(name: "group 1", description: "....")
    user1 = User.create(name: "My Name", email: "email@email.com", password: "password", password_confirmation: "password")
    user2 = User.create(name: "My Name2", email: "email2@email.com", password: "password", password_confirmation: "password")
    user3 = User.create(name: "My Name3", email: "email3@email.com", password: "password", password_confirmation: "password")

    question1 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["1"], created_at: DateTime.now - 20)
    question2 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "2", tag_ids: ["2"])
    question3 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "3", tag_ids: ["2"])
    question4 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["1"], created_at: DateTime.now - 20)
    question5 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["1"])

    answer1 = Answer.create(content: "....", user_id: "1", question_id: "1")
    answer2 = Answer.create(content: "....", user_id: "1", question_id: "2")
    answer3 = Answer.create(content: "....", user_id: "1", question_id: "2")
    expect(Tag.most_popular_by_users).to eq(tag2)
  end
end

describe ".most_active_user" do
  it "knows user who asked most questions with this tag" do
    tag1 = Tag.create(name: "popular")
    group1 = Group.create(name: "group 1", description: "....")
    user1 = User.create(name: "My Name", email: "email@email.com", password: "password", password_confirmation: "password")
    user2 = User.create(name: "My Name2", email: "email2@email.com", password: "password", password_confirmation: "password")

    question1 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["1"])
    question2 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["1"])
    question3 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "2", tag_ids: ["1"])
    question4 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "2", tag_ids: ["1"])
    question5 = Question.create(title: "question", content: "whatver", group_id: "1", user_id: "1", tag_ids: ["1"])

    answer1 = Answer.create(content: "....", user_id: "1", question_id: "1")
    answer2 = Answer.create(content: "....", user_id: "1", question_id: "2")
    answer3 = Answer.create(content: "....", user_id: "1", question_id: "2")
    expect(tag1.most_active_user).to eq(user1)
  end
end
