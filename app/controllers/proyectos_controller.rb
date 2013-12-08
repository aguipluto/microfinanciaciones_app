class ProyectosController < ApplicationController
  before_action :admin_user

  def index
    @proyectos = Proyecto.paginate(page: params[:page], per_page: 50)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @proyecto = Proyecto.new
  end

  def create
    @proyecto = current_user.proyectos.build(proyecto_params)
    if @proyecto.save
      params[:proyecto][:attachment_array].each do |file|
        @attachment = @proyecto.attachments.build(:attachment => file)
        @attachment.save
      end
      flash[:success] = "Proyecto creado!"
      redirect_to @proyecto
    else
      render 'new'
    end
  end

  def destroy
    Proyecto.find(params[:id]).destroy
    flash[:success] = "Proyecto borrado."
    redirect_to proyectos_url
  end

  def edit
  end

  def show
    @proyecto = Proyecto.find(params[:id])
    @cartitem = CartItem.new(proyecto_id: @proyecto.id)
  end

  def add_to_cart
    @proyecto = Proyecto.find(params[:id])
    current_user.cart.add_item(id: @proyecto.id, name: @proyecto.titulo, cost: params[:microfinanciacion])
  end


  private

  def proyecto_params
    params.require(:proyecto).permit(:titulo, :descripcion_corta, :descripcion_larga, :lugar, :fecha_inicio,
                                      :fecha_fin, :cantidad_total, :inicio_aportaciones, :fin_aportaciones, :attachments_array)
  end

end