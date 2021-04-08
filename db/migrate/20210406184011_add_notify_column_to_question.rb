class AddNotifyColumnToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :notify_author, :boolean, default: true
  end
end
