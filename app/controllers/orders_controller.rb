# encoding: utf-8
class OrdersController < ApplicationController
  before_action :correct_user, only: [:show]
  after_action :set_order_shown, only: [:show]

  def new
    @order = Order.includes([:cart]).where('express_token = ? AND carts.purchased_at IS NOT NULL', params[:token]).first
    if @order
      redirect_to @order
    else
      @order = Order.new(:express_token => params[:token])
    end
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
    id = nil #Para que puedan hacerse pagos anónimos, de no quererse se puede poner filtro :signed_in_user para create
    id = current_user.id unless current_user.nil?
    @order.user_id = id
    @order.ip_address = request.remote_ip
    if @order.save
      if @order.purchase(id)
        redirect_to @order
      else
        render :action => 'failure'
      end
    else
      render :action => 'new'
    end
  end

  def show

  end


  private

  def order_params
    params.require(:order).permit(:express_token, :invoice_name, :invoice_nif, :invoice_others)
  end

  def correct_user
    @order = Order.find(params[:id])
    unless @order.user_id.nil? #Donaciones anónimas
      @user = User.find(@order.user_id)
      redirect_to(root_url) unless (current_user?(@user) || current_user.admin?)
    end
  end

  def set_order_shown
    @order.update_attribute(:shown, true)
  end

end
