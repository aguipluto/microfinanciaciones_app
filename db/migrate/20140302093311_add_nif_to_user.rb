class AddNifToUser < ActiveRecord::Migration
  def change
    add_column :users, :nif, :string
  end
end
