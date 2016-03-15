# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :statuses
  has_many :groups, through: :statuses
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email, :name
  validates :password, length: {minimum: 6, maximum: 16}
  #will make custom email validation later

  


end
