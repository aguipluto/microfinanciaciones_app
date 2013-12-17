class AddUserIdToOrdersAndTransactions < ActiveRecord::Migration
  def change
    add_column :orders, :user_id, :integer
    add_column :order_transactions, :user_id, :integer
  end
end
