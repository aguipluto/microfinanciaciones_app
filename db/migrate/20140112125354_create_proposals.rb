class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :name
      t.string :family_name
      t.string :email
      t.string :organization
      t.string :phone
      t.text :description
      t.string :user_id

      t.timestamps
    end
  end
end
