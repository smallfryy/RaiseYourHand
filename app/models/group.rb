# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base
  has_many :statuses
  has_many :users, through: :statuses
  validate_presence_of :user_id, :group_id, :status
end
