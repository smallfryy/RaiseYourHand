# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

class Group < ActiveRecord::Base
  has_many :statuses
  has_many :users, through: :statuses
  has_many :questions
  validates_presence_of :name, :description
  validates_uniqueness_of :name

  def self.most_popular_by_questions
    Group.joins(:questions).group("groups.id").order("COUNT(questions.id) desc").first
  end

  def self.most_answered
    Group.joins(questions: :answers).group("groups.id").order("COUNT(answers.id) desc").first
  end

  def self.least_answered
    Group.joins(questions: :answers).group("groups.id").order("COUNT(DISTINCT(answers.id)) asc").first
  end

  def self.biggest_group
    Group.joins(:users).group("groups.id").order("COUNT(DISTINCT(users.id)) desc").first
  end

  def self.trending_group
    #most popular tag within last week by question
    Group.joins(:questions).where("questions.created_at > ?", DateTime.now - 7).group("groups.id").order("COUNT(questions.id) desc").first
  end

  def most_active_group
    Group.joins(:questions).where("tags.id = ?", self.id).group("users.id").order("COUNT(questions.id) desc").first
  end

  def admins
    User.joins(:statuses).where("statuses.group_id = ?", self.id).where("statuses.status = ?", "admin")
  end
  
   def users
    User.joins(:statuses).where("statuses.group_id = ?", self.id)
  end

  #need to build out admin panel for approving members etc
  def members
    users.where.not("statuses.status = ?", "pending")
  end

  def pending
    users.where("statuses.status = ?", "pending")
  end


end
