class CreateEdits < ActiveRecord::Migration
  def change
    create_table :edits do |t|
      t.integer :translation_id
      t.integer :user_id
      t.string :status, default: 'new'
      t.text :original_text
      t.text :suggested_text

      t.timestamps
    end
    add_index :edits, :translation_id
    add_index :edits, :user_id
    add_index :edits, :status
  end
end
