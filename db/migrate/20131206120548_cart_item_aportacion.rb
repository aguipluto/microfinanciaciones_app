class CartItemAportacion < ActiveRecord::Migration
  def change
    add_column :cart_items, :aportacion, :decimal, :precision => 6, :scale => 2, :null => false, :default => '0'
  end
end
