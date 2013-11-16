class CantidadTotalPrecision < ActiveRecord::Migration
  def change
    change_column :proyectos , :cantidad_total, :decimal, :precision => 6, :scale => 2, :null => false, :default => '0'
  end
end
