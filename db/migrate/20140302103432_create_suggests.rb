class CreateSuggests < ActiveRecord::Migration
  def change
    create_table :suggests do |t|
      t.string :title
      t.string :name
      t.string :email
      t.string :tel
      t.text :suggestion
      t.integer :user_id

      t.timestamps
    end
  end
end
