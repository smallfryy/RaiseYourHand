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

require 'spec_helper'

describe "Group" do 
    it "is invaid without name" do 
      group1 = Group.create(name: nil)
      group2 = Group.create(name: "")
      group3 = Group.create(name: "Group Name")

      expect(group1.errors.full_messages).to include "Name can't be blank"
      expect(group2.errors.full_messages).to include "Name can't be blank"
      expect(group3.errors.full_messages).to_not include "Name can't be blank"
  end

     it "is invaid without description" do 
      group1 = Group.create(description: nil)
      group2 = Group.create(description: "")
      group3 = Group.create(description: "Group description")

      expect(group1.errors.full_messages).to include "Description can't be blank"
      expect(group2.errors.full_messages).to include "Description can't be blank"
      expect(group3.errors.full_messages).to_not include "Description can't be blank"
  end

  it "is invaid without unique name" do 
    binding.pry
      group1 = Group.create(name: "My Amazing Group", description: "My amazing description")
      
      group2 = Group.create(name: "My Group", description: "My description")
      group3 = Group.create(name: "My Group", description: "My other description")

      expect(group1.errors.full_messages).to_not include "Name has already been taken"
      expect(group2.errors.full_messages).to_not include "Name has already been taken"
      expect(group3.errors.full_messages).to include "Name has already been taken"
  end
end






