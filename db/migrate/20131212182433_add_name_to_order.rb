class AddNameToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :first_name, :string
    add_column :orders, :second_name, :string
  end
end
