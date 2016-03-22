# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  question_id :integer
#  user_id     :integer
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe "Answer" do 
    it "is invalid without content" do 
      answer1 = Answer.create(content: nil)
      answer2 = Answer.create(content: "")
      answer3 = Answer.create(content: "This is my answer.")

      expect(answer1.errors.full_messages).to include "Content can't be blank"
      expect(answer2.errors.full_messages).to include "Content can't be blank"
      expect(answer3.errors.full_messages).to_not include "Content can't be blank"
    end
  end