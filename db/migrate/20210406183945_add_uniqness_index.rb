class AddUniqnessIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :subscriptions, [:user_id, :question_id], unique: true
  end
end
