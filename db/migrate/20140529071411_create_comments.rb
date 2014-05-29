class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :text
      t.references :commentable, polymorphic: true, index: true

      t.timestamps
    end
    add_index :comments, :user_id
  end
end
