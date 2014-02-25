# encoding: utf-8
class OrdersController < ApplicationController
  def new
    @order = Order.new(:express_token => params[:token])
  end

  def express
    response = EXPRESS_GATEWAY.setup_purchase(session_cart.build_order.price_in_cents,
                                              :ip => request.remote_ip,
                                              :return_url => new_order_url,
                                              :cancel_return_url => proyectos_url,
                                              currency: 'EUR',
                                              brand_name: 'Fundación Universitaria San Pablo CEU',
                                              allow_guest_checkout: 'true',
                                              items: session_cart.cart_items_in_array_of_hashs
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def create
    @order = session_cart.build_order(order_params)
    @order.user_id = current_user.id
    @order.ip_address = request.remote_ip
    if @order.save
      if @order.purchase(current_user.id)
        render :action => 'success'
        session_cart
      else
        render :action => 'failure'
      end
    else
      render :action => 'new'
    end
  end


  private

  def order_params
    params.require(:order).permit(:express_token)
  end

end
