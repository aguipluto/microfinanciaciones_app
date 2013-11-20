class AddProyectoIdToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :proyecto_id, :integer
  end
end
