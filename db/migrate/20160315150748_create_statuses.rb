class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :status

      t.timestamps null: false
    end
  end
end
