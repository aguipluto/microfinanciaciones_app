class AddAnswerToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :answer, :text
  end
end
