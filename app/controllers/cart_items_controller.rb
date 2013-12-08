# encoding: utf-8
class CartItemsController < ApplicationController

  # GET /shopping/cart_items
  def index
    @cart_items = session_cart.cart_items
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

end
