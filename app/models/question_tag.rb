# == Schema Information
#
# Table name: question_tags
#
#  id          :integer          not null, primary key
#  tag_id      :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class QuestionTag < ActiveRecord::Base
  belongs_to :question
  belongs_to :tag
  validates_presence_of :tag_id, :question_id
end
