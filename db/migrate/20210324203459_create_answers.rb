class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.string :title
      t.text :body
      t.belongs_to :question, index: true

      t.timestamps
    end
  end
end
