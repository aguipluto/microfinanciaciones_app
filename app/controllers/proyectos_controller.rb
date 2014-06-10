# encoding: utf-8
class ProyectosController < ApplicationController
  include ApplicationHelper
  before_action :admin_user, only: [:index, :new, :create, :update, :edit]
  helper_method :sort_column, :sort_direction

  def index
    @proyectos = Proyecto.search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)
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
      if params[:proyecto][:attachment_array]
        params[:proyecto][:attachment_array].each do |file|
          @attachment = @proyecto.attachments.build(:image => file)
          @attachment.save
        end
      end
      flash[:success] = "Proyecto creado!"
      redirect_to @proyecto
    else
      render 'new'
    end
  end

  def destroy
    proyecto = Proyecto.find(params[:id])
    proyecto.toggle!(:visible)
    flash[:success] = "Proyecto borrado."
    redirect_to proyectos_url
  end

  def edit
    @proyecto = Proyecto.find(params[:id])
  end

  def modal
    @proyecto = Proyecto.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def pb
    if(params[:tag])
      f = Proyecto.tagged_with(params[:tag])
    else
      f = Proyecto.all
    end

    if (params[:select].nil? || params[:select] == 'Todos')
      @proyectos = f.visibles(params[:search])
    elsif params[:select] == 'Activos'
      @proyectos = f.aportables(params[:search])
    elsif params[:select] == 'Cerrados'
      @proyectos = f.no_aportables(params[:search])
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @proyecto = Proyecto.find(params[:id])
    @cartitem = CartItem.new(proyecto_id: @proyecto.id)

    respond_to do |format|
      #format.json { render :json => @proyecto }
      format.html
    end
  end


  def add_to_cart
    @proyecto = Proyecto.find(params[:id])
    current_user.cart.add_item(id: @proyecto.id, name: @proyecto.titulo, cost: params[:microfinanciacion])
  end

  def update
    respond_to do |format|
      @proyecto = Proyecto.find(params[:id])
      if @proyecto.update_attributes(proyecto_params)
        if params[:proyecto][:attachment_array]
          params[:proyecto][:attachment_array].each do |file|
            @attachment = @proyecto.attachments.build(:image => file)
            @attachment.save
          end
        end
        format.js
        format.html do
          flash[:success] = "Proyecto actualizado"
          redirect_to @proyecto
        end
      else
        render 'edit'
      end
    end
  end

  def destroy_attachment
    Attachment.find(params[:id]).destroy
    response = {:message => 'Imagen borrada con éxito'}
    respond_to do |format|
      format.json { render :json => response }
      format.html
    end
  end

  private

  def proyecto_params
    params.require(:proyecto).permit(:titulo, :descripcion_corta, :descripcion_larga, :lugar, :fecha_inicio,
                                     :fecha_fin, :cantidad_total, :inicio_aportaciones, :fin_aportaciones, :attachments_array,
                                     :visible, :tag_list)
  end

  def sort_column
    Proyecto.column_names.include?(params[:sort]) ? params[:sort] : "fin_aportaciones"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end