# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#

class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  has_secure_password 
  has_many :questions
  has_many :answers
  has_many :statuses
  has_many :groups, through: :statuses
  validates_presence_of :name, :email
  validates_presence_of :password, :password_confirmation
  validates_uniqueness_of :email, :name
  validates :password, length: {minimum: 6, maximum: 16}
  validates :password_confirmation, length: {minimum: 6, maximum: 16}
 

  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  def group_status(group)
    User.joins(:statuses).where('statuses.group_id = ? AND statuses.user_id = ?', group.id, self.id).where.not("statuses.status = ?", "pending").pluck('statuses.status').first
  end


  def admin_of_groups
     Group.joins(:statuses).where("statuses.user_id =? AND statuses.status = ?", self.id, "admin")
  end

  def most_recent_questions
    self.questions.order('questions.created_at desc').first(5)
  end

  def most_recent_answers
    self.answers.order('answers.created_at desc').first(5)
  end
end
