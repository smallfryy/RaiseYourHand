# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

describe "Tag" do 
  it "is invaid without name" do 
    tag1 = Tag.create(name: nil)
    tag2 = Tag.create(name: "")
    tag3 = Tag.create(name: "This is my tag.")

    expect(tag1.errors.full_messages).to include "Name can't be blank"
    expect(tag2.errors.full_messages).to include "Name can't be blank"
    expect(tag3.errors.full_messages).to_not include "Name can't be blank"
  end
end