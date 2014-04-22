# encoding: utf-8
class CartItemsController < ApplicationController
  before_action :admin_user, only: [:indexAdmin]
  before_action :signed_in_user, only: [:create, :prueba]
  helper_method :sort_column, :sort_direction


  # GET /shopping/cart_items
  def index
    @cart_items = session_cart.cart_items
  end

  def indexAdmin
    @cart_items = cart_items_search
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /shopping/cart_items
  def create
    session_cart.save if session_cart.new_record?
    aportacion = params[:cart_item][:aportacion].to_f
    @cartitem = session_cart.add_proyecto(params[:cart_item][:proyecto_id], current_user.id, aportacion)
    if @cartitem.save
      flash[:success] = "Carrito creado!"
      redirect_to session_cart
    else
      proyecto = Proyecto.find_by_id(params[:cart_item][:proyecto_id])
      if proyecto
        redirect_to proyecto
      else
        flash[:notice] = 'Hubo algún error'
        redirect_to root_url
      end
    end
  end

  def prueba
    session_cart.save if session_cart.new_record?
    aportacion = params[:aportacion].to_f
    @cartitem = session_cart.add_proyecto(params[:proyecto_id], current_user.id, aportacion)
    if @cartitem.save
      respond_to do |format|
        format.json { render :json => session_cart }
        format.html
      end
    else
      render :json => {:errors => session_cart.errors.full_messages}
    end
  end


#  aportacion = params[:cart_item][:aportacion].to_f
#  if cart_item = session_cart.add_proyecto(params[:cart_item][:proyecto_id]., current_user.id, aportacion)
#    redirect_to(session_cart)
#  else
#    proyecto = Proyecto.find_by_id(params[:cart_item][:proyecto_id])
#    if proyecto
#      redirect_to proyecto
#    else
#      flash[:notice] = 'Hubo algún error'
#      redirect_to root_url
#    end
#  end
#end

# DELETE /carts/1
# DELETE /carts/1.xml
  def destroy
    session_cart.remove_proyecto(params[:proyecto_id]) if params[:proyecto_id]
    redirect_to(cart_items_url)
  end

  private
  def cartitem_params
    params.require(:cart_item).permit(:aportacion, :proyecto_id)
  end

  def sort_column
    %w[proyectos.titulo users.family_name aportacion carts.purchased_at id].include?(params[:sort]) ? params[:sort] : "proyectos.titulo"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def cart_items_search
    if params[:aportationType] == nil || params[:aportationType] == 'Pagadas'
      @cart_items = CartItem.joins(cart: :order).includes([:proyecto, :cart, :user]).search(params[:search], params[:aportationType]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 15)
    elsif params[:aportationType] && params[:aportationType] == 'Sin Pagar'
      @cart_items = CartItem.includes([:proyecto, :cart, :user]).search(params[:search], params[:aportationType]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 15)
    else
      @cart_items = CartItem.includes([:proyecto, :cart, :user]).search(params[:search], params[:aportationType]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 15)
    end
  end

end
