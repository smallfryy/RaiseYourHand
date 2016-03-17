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
  it "is invaid without email" do 
      user1 = Group.create(email: nil)
      user2 = Group.create(email: "")
      user3 = Group.create(email: "user@user.com")

      expect(user1.errors.full_messages).to include "email can't be blank"
      expect(user2.errors.full_messages).to include "email can't be blank"
      expect(user3.errors.full_messages).to_not include "email can't be blank"
  end

  #help
  it "is invaid without unique name" do
      user1 = User.create(name: "My Amazing Name", email: "holly@holly.com")  
      user2 = User.create(name: "My Name", email: "email@email.com")
      user3 = User.create(name: "My Name", email: "email@email.com")

      expect(user1.errors.full_messages).to_not include "Name has already been taken"
      expect(user2.errors.full_messages).to_not include "Name has already been taken"
      expect(user3.errors.full_messages).to include "Name has already been taken"
  end

end
