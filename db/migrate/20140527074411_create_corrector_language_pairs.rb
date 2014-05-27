class CreateCorrectorLanguagePairs < ActiveRecord::Migration
  def change
    create_table :corrector_language_pairs do |t|
      t.integer :user_id
      t.integer :from_language_id
      t.integer :to_language_id
    end
    add_index :corrector_language_pairs, :user_id
    add_index :corrector_language_pairs, :from_language_id
    add_index :corrector_language_pairs, :to_language_id
  end
end
