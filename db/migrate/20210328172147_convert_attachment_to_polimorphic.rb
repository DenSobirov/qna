class ConvertAttachmentToPolimorphic < ActiveRecord::Migration[6.1]
  def change
    rename_column :attachments, :question_id, :attachable_id
    add_column :attachments, :attachable_type, :string
    add_index :attachments, [:attachable_id, :attachable_type]
  end
end
