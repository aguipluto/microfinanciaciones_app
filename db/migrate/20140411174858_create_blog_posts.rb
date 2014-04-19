class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :proyecto_id
      t.string :author

      t.timestamps
    end
  end
end
