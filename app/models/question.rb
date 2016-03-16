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

class Question < ActiveRecord::Base
  has_many :answers
  has_many :question_tags
  has_many :tags, through: :question_tags 
  belongs_to :user 
  belongs_to :group
  validates_presence_of :user_id, :group_id, :content, :title
  
  def tag_name=(name)
    #binding.pry
    tag = Tag.find_or_create_by(name: name)
    self.tags << tag
  end

  def tag_name
  end

  




end
