class CreateProyectos < ActiveRecord::Migration
  def change
    create_table :proyectos do |t|
      t.string :titulo
      t.string :lugar
      t.date :fecha_inicio
      t.date :fecha_fin
      t.string :descripcion_corta
      t.text :descripcion_larga
      t.decimal :cantidad_total
      t.datetime :inicio_aportaciones
      t.datetime :fin_aportaciones
      t.integer :user_id

      t.timestamps
    end
  end
end
