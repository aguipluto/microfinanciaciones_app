class AddApprovedToBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :approved, :boolean, default: false
  end
end
