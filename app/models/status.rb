# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  group_id   :integer
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  validates_presence_of :user_id, :group_id, :status
end
