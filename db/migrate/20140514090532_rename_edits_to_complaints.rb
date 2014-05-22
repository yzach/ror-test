class RenameEditsToComplaints < ActiveRecord::Migration
  def up
    remove_column :edits, :suggested_text
    rename_column :edits, :original_text, :text
    rename_table :edits, :complaints
  end
end
