class CreateVolunteer < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.belongs_to :user
      t.belongs_to :proyecto

      t.timestamps
    end
  end
end
