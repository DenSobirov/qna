class AddQuestionToAttachment < ActiveRecord::Migration[6.1]
  def change
    add_column :attachments, :question_id, :integer
    add_index :attachments, :question_id
  end
end
