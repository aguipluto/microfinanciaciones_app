class AddShowToSuggestion < ActiveRecord::Migration
  def change
    add_column :suggests, :shown, :boolean, default: :false
    add_column :suggests, :answer, :text
    add_column :suggests, :answer_date, :datetime
  end
end
