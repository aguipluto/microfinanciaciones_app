class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :proyecto_id
      t.integer :user_id
      t.integer :cart_id
      t.boolean :active
      t.timestamps
    end
  end
end
