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
end
