class AddDeleteToProyectos < ActiveRecord::Migration
  def change
    add_column :proyectos, :visible, :boolean, default: true
  end
end
