# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  has_many :question_tags
  has_many :questions, through: :question_tags
  validates_presence_of :name

  def most_popular_by_questions
    Tag.joins(:questions).group("tags.id").order("COUNT(questions.id) desc").first
  end

  def self.most_answers
    Tag.joins(questions: :answers).group("tags.id").order("COUNT(answers.id) desc").first
  end

  def self.least_answered
    Tag.joins(questions: :answers).group("tags.id").order("COUNT(answers.id) asc").first
  end

  def self.most_popular_by_users
    Tag.joins(questions: :user).group("tags.id").order("COUNT(users.id) desc").first

  end

  def self.trending_tag
    #most popular tag within last week by question
    Tag.joins(:questions).where("questions.created_at > ?", DateTime.now - 7).group("tags.id").order("COUNT(questions.id) desc").first
  end
  def most_active_user
    User.joins(questions: :tags).where("tags.id = ?", self.id).group("users.id").order("COUNT(questions.id), desc").first
  end
end
