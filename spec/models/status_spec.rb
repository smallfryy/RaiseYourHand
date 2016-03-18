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
describe "Status" do 
  it "is invaid without status" do 
    status1 = Status.create(status: nil)
    status2 = Status.create(status: "")
    status3 = Status.create(status: "This is my status.")

    expect(status1.errors.full_messages).to include "Status can't be blank"
    expect(status2.errors.full_messages).to include "Status can't be blank"
    expect(status3.errors.full_messages).to_not include "Status can't be blank"
  end
  it "is invaid without user" do 
    status1 = Status.create(user_id: nil)
    status2 = Status.create(user_id: "")
    status3 = Status.create(user_id: "1")

    expect(status1.errors.full_messages).to include "User can't be blank"
    expect(status2.errors.full_messages).to include "User can't be blank"
    expect(status3.errors.full_messages).to_not include "User can't be blank"
  end
  it "is invaid without user" do 
    status1 = Status.create(group_id: nil)
    status2 = Status.create(group_id: "")
    status3 = Status.create(group_id: "1")

    expect(status1.errors.full_messages).to include "Group can't be blank"
    expect(status2.errors.full_messages).to include "Group can't be blank"
    expect(status3.errors.full_messages).to_not include "Group can't be blank"
  end
end