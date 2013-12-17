class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :cart_id
      t.string :ip_address
      t.string :cart_type
      t.date :card_expires_on

      t.timestamps
    end
  end
end
