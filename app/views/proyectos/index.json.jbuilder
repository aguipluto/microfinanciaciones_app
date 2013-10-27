json.array!(@proyectos) do |proyecto|
  json.extract! proyecto, :nombre, :lugar, :descripcion_corta, :descripcion_larga, :fecha_inicio_proyecto, :fecha_fin_proyecto, :fecha_inicio_recaudacion, :fecha_fin_recaudation
  json.url proyecto_url(proyecto, format: :json)
end