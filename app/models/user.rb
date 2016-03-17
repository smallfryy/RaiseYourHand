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
  #will make custom email validation later

  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
end
