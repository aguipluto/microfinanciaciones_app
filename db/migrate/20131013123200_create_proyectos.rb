class CreateProyectos < ActiveRecord::Migration
  def change
    create_table :proyectos do |t|
      t.string :nombre
      t.string :lugar
      t.string :descripcion_corta
      t.text :descripcion_larga
      t.date :fecha_inicio_proyecto
      t.date :fecha_fin_proyecto
      t.datetime :fecha_inicio_recaudacion
      t.datetime :fecha_fin_recaudation

      t.timestamps
    end
  end
end
