class AddStatusToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :status, :string, default: 'Pendiente revisión'
  end
end
