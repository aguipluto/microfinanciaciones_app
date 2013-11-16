class ProyectosController < ApplicationController
  before_action :admin_user

  def new
    @proyecto = Proyecto.new
  end

  def create
    @proyecto = current_user.proyectos.build(proyecto_params)
    if @proyecto.save
      flash[:success] = "Proyecto creado!"
      redirect_to @proyecto
    else
      render 'new'
    end
  end

  def destroy
  end

  def edit
  end

  def show
    @proyecto = Proyecto.find(params[:id])
  end

  private

  def proyecto_params
    params.require(:proyecto).permit(:titulo, :descripcion_corta, :descripcion_larga, :lugar, :fecha_inicio,
                                      :fecha_fin, :cantidad_total, :inicio_aportaciones, :fin_aportaciones)
  end

end