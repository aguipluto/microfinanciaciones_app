class AddBlogEditorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :blog_editor, :boolean, default: false
  end
end
