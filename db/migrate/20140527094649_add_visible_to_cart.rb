class AddVisibleToCart < ActiveRecord::Migration
  def change
    add_column :carts, :visible_cart, :boolean, default: :false
  end
end
