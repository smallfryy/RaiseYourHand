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

require 'spec_helper'

describe "User" do 
  it "is invalid without name" do 
    user1 = User.create(name: nil)
    user2 = User.create(name: "")
    user3 = User.create(name: "User Name")

    expect(user1.errors.full_messages).to include "Name can't be blank"
    expect(user2.errors.full_messages).to include "Name can't be blank"
    expect(user3.errors.full_messages).to_not include "Name can't be blank"
  end

  # this is not passing idk why
  it "is invalid without email" do 
      user1 = User.create(email: nil)
      user2 = User.create(email: "")
      user3 = User.create(email: "user@user.com")

      expect(user1.errors.full_messages).to include "Email can't be blank"
      expect(user2.errors.full_messages).to include "Email can't be blank"
      expect(user3.errors.full_messages).to_not include "Email can't be blank"
  end

  #help
  it "is invalid without unique name" do
      user1 = User.create(name: "My Amazing Name", email: "holly@holly.com")  
      user2 = User.create(name: "My Name", email: "email@email.com", password: "password", password_confirmation: "password")
      user3 = User.create(name: "My Name", email: "email@email.com")

      expect(user1.errors.full_messages).to_not include "Name has already been taken"
      expect(user2.errors.full_messages).to_not include "Name has already been taken"
      expect(user3.errors.full_messages).to include "Name has already been taken"
  end

  it "validates email format" do
    user1 = User.create(email: "hahahanicetry")

    expect(user1.errors.full_messages).to include "Email is invalid"
  end

  it "should have many questions" do
    t = User.reflect_on_association(:questions)
    expect(t.macro).to equal(:has_many)
  end

  it "should have many answers" do
    t = User.reflect_on_association(:answers)
    expect(t.macro).to equal(:has_many)
  end

  it "should have many statuses" do
    t = User.reflect_on_association(:statuses)
    expect(t.macro).to equal(:has_many)
  end

  it "should have many groups" do
    t = User.reflect_on_association(:groups)
    expect(t.macro).to equal(:has_many)
  end

end
