class AddShownToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shown, :boolean, default: false
  end
end