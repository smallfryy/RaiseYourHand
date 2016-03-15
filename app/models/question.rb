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
  belongs_to :user 
  belongs_to :group
  validates_presence_of :user_id, :group_id, :content, :title
end
