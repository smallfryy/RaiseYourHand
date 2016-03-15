class CreateQuestionTags < ActiveRecord::Migration
  def change
    create_table :question_tags do |t|
      t.integer :tag_id
      t.integer :question_id

      t.timestamps null: false
    end
  end
end
