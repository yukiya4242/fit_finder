class CreateSavedFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :saved_files do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chat, null: false, foreign_key: true

      t.timestamps
    end
    add_index :saved_files, [:user_id, :chat_id], unique: true #ユーザーが特定のファイルを保存できるのは１度のみ
  end
end

