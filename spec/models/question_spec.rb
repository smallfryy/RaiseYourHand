# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  group_id   :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#

require 'spec_helper'

describe "Question" do 
    it "is invalid without content" do 
      question1 = Question.create(content: nil)
      question2 = Question.create(content: "")
      question3 = Question.create(content: "This is my question.")

      expect(question1.errors.full_messages).to include "Content can't be blank"
      expect(question2.errors.full_messages).to include "Content can't be blank"
      expect(question3.errors.full_messages).to_not include "Content can't be blank"
    end
    it "is invalid without title" do 
      question1 = Question.create(title: nil)
      question2 = Question.create(title: "")
      question3 = Question.create(title: "What?")

      expect(question1.errors.full_messages).to include "Title can't be blank"
      expect(question2.errors.full_messages).to include "Title can't be blank"
      expect(question3.errors.full_messages).to_not include "Title can't be blank"
    end
    it "is invalid without group" do 
      question1 = Question.create(group_id: nil)
      question2 = Question.create(group_id: "")
      question3 = Question.create(group_id: "1")

      expect(question1.errors.full_messages).to include "Group can't be blank"
      expect(question2.errors.full_messages).to include "Group can't be blank"
      expect(question3.errors.full_messages).to_not include "Group can't be blank"
    end
    it "is invalid without user" do 
      question1 = Question.create(user_id: nil)
      question2 = Question.create(user_id: "")
      question3 = Question.create(user_id: "1")

      expect(question1.errors.full_messages).to include "User can't be blank"
      expect(question2.errors.full_messages).to include "User can't be blank"
      expect(question3.errors.full_messages).to_not include "User can't be blank"
    end
end