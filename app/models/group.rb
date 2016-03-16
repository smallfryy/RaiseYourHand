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
